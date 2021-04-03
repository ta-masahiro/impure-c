#include "vm.h"
#include "lexparse.h"

void disassy(Vector*v,int i,FILE*fp);

int op2_1[] = {'+', '-', '*', '/', '>', '<', '='*256+'=', '>'*256+'=', '<'*256+'=',0};
enum CODE op2_2[5][10] = {{0,0,0,0,0,0,0,0,0,0,},    
                //{ADD,  SUB,  MUL,  DIV,  GT,  LT,  EQ,  GEQ,  LEQ , 0},
                {IADD, ISUB, IMUL, IDIV, IGT, ILT, IEQ, IGEQ, ILEQ, 0},
                {LADD, LSUB, LMUL, LDIV, LGT, LLT, LEQ, LGEQ, LLEQ, 0},
                {RADD, RSUB, RMUL, RDIV, RGT, RLT, REQ, RGEQ, RLEQ, 0},
                {FADD, FSUB, FMUL, FDIV, FGT, FLT, FEQ, FGEQ, FLEQ, 0}};
int op1_1[] = {'-', '~', '+'*256+'+', '-'*256+'-',0};
enum CODE op1_2[5][4] = {{0,0,0,0},
              //{NEG, BNOT,INC,DEC},
                {INEG, BNOT, INC,  DEC },
                {LNEG, 0,    LINC, LDEC},
                {RNEG, 0,    0,    0   },
                {FNEG, 0,    0,    0   }};
enum CODE conv_op[5][7] = {{0, 0,    0,    0,    0,    0, 0   },
                        {0, 0,    ITOL, ITOR, ITOF, 0, ITOO},
                        {0, LTOI, 0   , LTOR, LTOF, 0, LTOO},
                        {0, RTOI, RTOL, 0   , RTOF, 0, RTOO},
                        {0, FTOI, FTOL, FTOR, 0   , 0, FTOO}};

enum CODE get_convert_op(obj_type from, obj_type to) {
    if (from<=to) return 0;
    return conv_op[from][to];
}

Hash* G;

Vector * var_location(Symbol * varname, Vector * env) { // env: [[(sym00:type00),  (sym01:type01),...], [(sym10:type10),(sym11),...]]
    int i,j;
    Vector * v, * nv, * rv;//printf("varname:%s\n",varname->_table);
    //obj_type type; 
    //if (is_stac_empty(env)) return NULL; 
    for(i = 0; i< env->_sp; i ++ ) {
        v = vector_ref(env,env->_sp-i-1);//vector_print(v);
        for (j = 0; j<v -> _sp; j ++ ) {//printf("env%d:%s\n",j,((Symbol*)vector_ref(v,j))->_table);printf("%d\n",symbol_eq(varname,vector_ref(v,j)));
            if (symbol_eq(varname, ((Data*)vector_ref(v, j))->key)) {
                nv = vector_init(2); 
                if (j==v->_sp-2 && strcmp(((Symbol*)vector_ref(v,j+1))->_table,"..")==0) j=-(j+1);
                push(nv, (void * )(long)i); push(nv, (void * )(long)j);
                rv=vector_init(2);
                push(rv,(void*)nv);push(rv,((Data*)vector_ref(v,j))->val); 
                return rv; // return [[pos_i,pos_j],obj_type]
            }
        }
    }
    rv=vector_init(2);push(rv,(void*)0);
    if (Hash_get(G,varname)) {
        Hash_put(G,varname, (void*)OBJ_GEN);
        push(rv,(void*)OBJ_GEN);
        return rv;
    } else { 
        push(rv,*Hash_get(G,varname));
        return NULL;
    }
}

typedef struct {
    Vector      *code;              // intermediate code
    obj_type    type;               // object type of code
    Vector*     arg_type;           // if type is function, parameter type
    obj_type    function_r_type;    // if type is function, function return type
    int         dotted;             // 0: normal function 1: dotted function
} code_ret;

code_ret*new_code(Vector*code,obj_type type) {
    code_ret*r=(code_ret*)malloc(sizeof(code_ret));
    r->code=code;r->type=type;r->arg_type=(void*)0;r->dotted=0;//
    return r;
}


code_ret * codegen(ast * a, Vector * env, int tail) {
    Vector * code = vector_init(10), *code1, *code2,*v,*v1,*v2,*v3,*a_arg_v,*d_arg_v,*pos,*_pos,*args,*v_expr_body;
    code_ret* code_s,*code_s1;
    //code_s->code=code;code_s->type=OBJ_NONE;
    ast *a0,* a1,*a2,*ast_list;
    int i,j,n,*tp,dcl_flg,m,dot; 
    long int_num;
    double fl_num,*fl_num_p;
    mpz_ptr z; mpq_ptr q;
    tokentype lit_type;
    obj_type ret_obj,type1,type2,r_type;
    Symbol*str_symbol;
    Data*d;
    //ast_print(a,0);
    switch(a->type) {
        case AST_ML:    //AST_ML [AST_expr_list [AST_1,AST_2,...]]
                        //                       <0,0> <0,1>
            dcl_flg = FALSE;
            ast_list=(ast*)vector_ref(a->table,0);//ast_print(ast_list,0);
            a_arg_v=vector_init(3);d_arg_v=vector_init(3);v_expr_body=vector_init(3);
            for(i=0;i<ast_list->table->_sp;i++) {
                a1=(ast*)vector_ref(ast_list->table,i);//ast_print(a1,0);
                if (a1->type==AST_DCL) {
                    dcl_flg=TRUE;
                    for(j=0;j<((ast*)vector_ref(a1->table,0))->table->_sp;j++) {
                        a2 = (ast*)vector_ref(((ast*)vector_ref(a1->table,0))->table,j);//ast_print(a2,0);
                        if (a2->type==AST_VAR) {                                        // a2:AST_VAR [symbol_var_name_]
                            v=vector_init(2);
                            push(v,(void*)TOKEN_NONE);push(v,(void*)NULL);
                            push(a_arg_v,new_ast(AST_LIT,OBJ_NONE,v));                           // a_arg_v:actual arg list
                            push(d_arg_v,(void*)a2);                                    // d_arg_v:dummy arg list
                        } else if (a2->type==AST_SET &&                                 // a2: AST_SET [set_type, AST_VAR [var_name], expr_ast]
                                    ((ast*)vector_ref(a2->table,1))->type==AST_VAR) {   //                        <1>                 <2>
                            push(a_arg_v,(void*)vector_ref(a2->table,2));               // a_arg_v:actual arg list
                            push(d_arg_v,(void*)vector_ref(a2->table,1));               // d_arg_v:dummy arg list
                        } else {
                            printf("Syntax error :decliation in ml_expr\n");
                            return NULL;
                        }
                    }
                } else {//printf("!!!\n");
                    if (i==ast_list->table->_sp-1) {
                        code_s1= codegen(a1,env,tail);      
                        //code=vector_append(code,codegen(a1,env,tail));//disassy(code,0);
                        ret_obj=code_s1->type;
                        code=vector_append(code,code_s1->code);
                        push(v_expr_body,(void*)a1);//ast_print(a1,0);
                    } else {
                        code_s1 = codegen(a1,env,FALSE);
                        code = vector_append(code,code_s1->code);
                        push(code,(void*)DROP);//disassy(code,0);
                        //code=vector_append(code,codegen(a1,env,FALSE));push(code,(void*)DROP);//disassy(code,0);
                        push(v_expr_body,(void*)a1);//ast_print(a1,0);
                    }
                }
            }
            if (dcl_flg==FALSE) {
                code_s=new_code(code,ret_obj);
                return code_s;
            } else {
                v1=vector_init(2);v2=vector_init(1);
                push(v1,(void*)new_ast(AST_EXP_LIST,OBJ_NONE, d_arg_v));//ast_print(new_ast(AST_EXP_LIST,OBJ_NONE,d_arg_v),0);//dummy arg list
                //push(v2,new_ast(AST_EXP_LIST,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v_expr_body));
                push(v2,new_ast(AST_EXP_LIST,OBJ_NONE,v_expr_body));
                //push(v1,(void*)new_ast(AST_ML,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v2));//ast_print(new_ast(AST_ML,v5),0) ;      // v3:[AST_EXP_LIST,AST_ML]
                push(v1,(void*)new_ast(AST_ML,OBJ_NONE,v2));//ast_print(new_ast(AST_ML,OBJ_NONE,v2),0) ;      // v3:[AST_EXP_LIST,AST_ML]
                //a1=new_ast(AST_LAMBDA,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v1);ast_print(a1,0);
                a1=new_ast(AST_LAMBDA,OBJ_NONE,v1);//ast_print(a1,0);
                //
                v3=vector_init(3);
                push(v3,(void*)a1);
                push(v3,(void*)new_ast(AST_EXP_LIST,OBJ_NONE,a_arg_v));   // actual arg list
                a2=new_ast(AST_FCALL,a1->o_type,v3);//ast_print(a2,0);                   // AST_FCALL [AST_LAMBDA [AST_EXP_LIST [..],AST_ML [...]],AST_EXP_LIST [...]]
                return codegen(a2,env,tail);
            }
        case AST_IF:    // AST_IF,[cond_expr,true_expr,false_expr]
            if (tail) { // -> cond_code TSEL true_code+RTN false_code+RTN
                //code = codegen(vector_ref(a -> table, 0),env,FALSE);                                // make cond_code 
                code_s1 = codegen(vector_ref(a -> table, 0),env,FALSE);
                code=code_s1->code;                                // make cond_code 
                //code1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)RTN);            // make true_code
                code_s1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)RTN);            // make true_code
                code1=code_s1->code;type1=code_s1->type;
                //code2 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)RTN);            // make false_code
                code_s1 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)RTN);            // make false_code
                code2=code_s1->code;type2=code_s1->type;
                push(code,(void*)TSEL);
                if (type1 == type2) {
                    push(code ,(void*)code1); push(code,(void*)code2);       // push TSEL and true_code,false_code
                    return new_code(code,type1);
                } else {
                    if (type1 != OBJ_GEN)  push(code1,(void*)conv_op[type1][OBJ_GEN]);
                    if (type2 != OBJ_GEN)  push(code2,(void*)conv_op[type2][OBJ_GEN]);
                    push(code,(void*)code1);push(code,(void*)code2);
                    return new_code(code,OBJ_GEN);
                }
            } else {    // -> cond_code SEL true_code+JOIN false_code+JOIN
                //code = codegen(vector_ref(a -> table, 0),env,FALSE);
                code_s1 = codegen(vector_ref(a -> table, 0),env,FALSE);
                code=code_s1->code;                                // make cond_code 
                //code1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)JOIN); 
                code_s1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)JOIN);            // make true_code
                code1=code_s1->code;type1=code_s1->type;
                //code2 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)JOIN); 
                code_s1 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)JOIN);            // make false_code
                code2=code_s1->code;type2=code_s1->type;
                push(code, (void * )SEL); //push(code,(void*)code1); push(code,(void*)code2);
                if (type1 == type2) {
                    push(code ,(void*)code1); push(code,(void*)code2);       // push TSEL and true_code,false_code
                    return new_code(code,type1);
                } else {
                    if (type1 != OBJ_GEN)  push(code1,(void*)conv_op[type1][OBJ_GEN]);
                    if (type2 != OBJ_GEN)  push(code2,(void*)conv_op[type2][OBJ_GEN]);
                    push(code,(void*)code1);push(code,(void*)code2);
                    return new_code(code,OBJ_GEN);
                }
            }
        case AST_SET:// AST_SET [set_type, AST_left_expr, AST_right_expr]
                switch(((ast*)vector_ref(a->table,1))->type) {
                    case AST_VREF:  // AST_SET [set_type, AST_VREF [vect_expr,index] ], right_expr]
                                    //          <0,0>               <1,0>     <1,1>    <2>
                                    // -> right_code vect_name_code index_code VSET
                        //code=codegen(vector_ref(a->table,2),env,FALSE);
                        code_s=codegen(vector_ref(a->table,2),env,FALSE);
                        code=code_s->code;type1=code_s->type;
                        //code1=codegen(vector_ref(a->table,1),env,FALSE);vector_set(code1,code1->_sp-1,(void*)VSET);
                        code_s=codegen(vector_ref(a->table,1),env,FALSE);
                        code1=code_s->code;type2=code_s->type;
                        //vector_set(code1,code1->_sp-1,(void*)VSET);
                        pop(code1);
                        if (type2 != OBJ_GEN) {
                           push(code1,(void*)conv_op[type2][OBJ_GEN]);
                        } 
                        push(code1,(void*)VSET);
                        return new_code(vector_append(code,code1),type2);
                    case AST_FCALL: // AST_SET [set_type,AST_FCALL [expr_name , expr_list],right_expr]
                                    //          <0,0>              <1,0>        <1,1>      <2>
                        a1=(ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,0);
                        v1=vector_init(2);
                        push(v1,(void*)(ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,1));//push expr_list
                        push(v1,(void*)vector_ref(a->table,2));
                        a2=new_ast(AST_LAMBDA,((ast*)vector_ref(a->table,2))->o_type,v1);
                        v2=vector_init(2);push(v2,(void*)(long)'=');
                        push(v2,(void*)a1);push(v2,(void*)a2);
                        return codegen(new_ast(AST_SET,a2->o_type,v2),env,FALSE);
                    case AST_VAR:   // AST_SET [set_type, AST_VAR [var_name], right_expr]
                                    //          <0,0>             <1,0>       <2>
                        _pos=var_location((Symbol*)vector_ref(((ast*)vector_ref(a->table,1))->table,0),env);
                        pos=(Vector*)vector_ref(_pos,0);type1=(obj_type)(long)vector_ref(_pos,1);
                        code_s=codegen((ast*)vector_ref(a->table,2),env,FALSE);
                        code=code_s->code;type2=code_s->type;
                        if (pos) {
                            if (type1 != type2) push(code,(void*)conv_op[type2][type1]);
                            push(code,(void*)SET);push(code,(void*)pos);
                        } else {
                            if (type1 != type2) push(code,(void*)conv_op[type2][type1]);
                            push(code,(void*)GSET);push(code,(void*)vector_ref(((ast*)vector_ref(a->table,1))->table,0));
                        }
                        return new_code(code,type2);
                    default:printf("jhdjadjaw4yy87wfhwj\n");
                }
        case AST_LAMBDA:    // AST_LAMBDA [AST_EXP_LIST [expr,   exp,   ...]], body_expr]
                            //                           <0,0,0>,<0,0,1>,...   <1>
            args=vector_init(3);
            v=vector_init(3);
            a1=(ast*)vector_ref(a->table,0);    //arg_list
            if ((a1->type != AST_ARG_LIST) && (a1->type != AST_ARG_LIST_DOTS)) {printf("SyntaxError:not argment list!\n");return NULL;}
            for(i=0;i<a1->table->_sp;i++) {
                a2=(ast*)vector_ref(a1->table,i);
                if (a2->type==AST_VAR) {
                    d=(Data*)malloc(sizeof(Data));
                    d->key=(Symbol*)vector_ref(a2->table,0);
                    d->val=(void*)a2->o_type;
                    push(args,(void*)d);push(v,(void*)a2->o_type);
                } else {printf("illegal argment!\n");}
            } //for(i=0;i<args->_sp;i++) printf("%s\t",((Symbol*)vector_ref(args,i))->_table);printf("\n");
            if (a1->type==AST_ARG_LIST_DOTS) {
                d=(Data*)malloc(sizeof(Data));
                d->key=new_symbol("..",3);
                d->val=OBJ_NONE;
                push(args,(void*)d);
            }
            push(env,(void*)args);
            code_s=codegen((ast*)vector_ref(a->table,1),env,TRUE);
            code1=code_s->code;type1=code_s->type;
            push(code1,(void*)RTN);
            push(code,(void*)LDF);push(code,(void*)code1);
            pop(env);// !!don't forget!!!
            code_s= new_code(code,OBJ_UFUNC);code_s->arg_type=v;code_s->function_r_type=type1;
            if (a1->type==AST_ARG_LIST_DOTS) code_s->dotted=1;
            return code_s;
        case AST_FCALL:     // AST_FCALL [AST_NAME,[AST_EXP_LIST [AST,AST,...]]]
                            //            <0>                     <1,0>,<1,1>...
            // ... macro function ...
            a1=(ast*)vector_ref(a->table,1);    // parameter ast
            a2=(ast*)vector_ref(a->table,0);    // function ast
            code_s=codegen(a2,env,FALSE);code2=code_s->code;            
            if (code_s->type != OBJ_UFUNC) {printf("SyntaxError:Must be Function!\n");return NULL;}
            r_type = code_s->function_r_type;
            v=code_s->arg_type;                 // list of dummy parameter type
            m = v->_cp-1;                       // number of dummy parameters
            n = a1->table->_sp;                 // number of actual parameters
            if (!(dot=code_s->dotted) && n != m) {printf("SyntaxError: Illegal parameter number!\n");return NULL;}
            if (a1->type==AST_EXP_LIST_DOTS) {                      // if expr_list_dots -> apply
                v1=vector_init(1+a1->table->_sp);
                push(v1,(void*)vector_ref(a->table,0));
                for(i=0;i<a1->table->_sp;i++) {
                    push(v1,(void*)vector_ref(a1->table,i));
                }
                v2=vector_init(1);
                push(v2,(void*)new_ast(AST_EXP_LIST_DOTS,((ast*)vector_ref(a1->table,a1->table->_sp-1))->o_type,v1));
                return codegen(new_ast(AST_APPLY,((ast*)vector_ref(a1->table,a1->table->_sp-1))->o_type,v2),env,tail);     // AST_APPLY [AST_EXP_LIST [expr0,expr1,...]]
            }
            // general case
            for(i=0;i<n;i++) {
                code_s = codegen((ast*)vector_ref(a1->table,i),env,FALSE);
                code1 = code_s->code;type1=code_s->type;                            // type1:actual parameter type
                if (dot && i >= m-1) type2=OBJ_GEN ; else type2 = (int)(long)vector_ref(v,i);  // type2:dummy parameter type
                if (type1 != type2) push(code1,(void*)conv_op[type1][type2]);
                code=vector_append(code,code1);
            }
            code = vector_append(code, code2);    // append Function name % expr_list
            push(code, tail ? (void*)TCALL : (void*)CALL);
            push(code, (void*)(long)n);
            code_s=new_code(code,OBJ_UFUNC);code_s->function_r_type=r_type;
            return code_s;
        case AST_APPLY: // AST_APPLY [AST_EXP_LIST [ast1, ast2, ...]]
                        //            <0>           <0,0>,<0,1e>,...    
            n=((ast*)vector_ref(a->table,0))->table->_sp;//printf("%d\n",n);
            for(i=0;i<n;i++) {
                code_s = codegen((ast*)vector_ref(((ast*)vector_ref(a->table,0))->table,i),env,FALSE);//disassy(code,0);
                code1 = code_s->code;type1 = code_s->type;
                if (i==0) {
                    if (type1 != OBJ_UFUNC) {printf("SyntaxError:Must be Function!\n");return NULL;}
                    r_type = code_s->function_r_type;
                }
                if (i==n-1 && type1 != OBJ_VECT) {printf("SyntaxError:Must be Vector!\n");return NULL;}
                if (type1 != OBJ_GEN) push(code,(void*)conv_op[type1][OBJ_GEN]);
                code = vector_append(code,code1);//disassy(code,0);
            }
            if (tail) {
                push(code, (void*)TAPL);push(code, (void*)(long)n);
            } else {
                push(code, (void*)APL);push(code, (void*)(long)n);
            }
            return new_code(code,r_type);
        case AST_2OP:   // AST_2OP [op_type,AST_L_EXPR,AST_R_EXPR]
            code_s = codegen((ast*)vector_ref(a->table,1),env,FALSE);
            code1=code_s->code;type1=code_s->type;//disassy(code1,0);
            code_s = codegen((ast*)vector_ref(a->table,2),env,FALSE);
            code2=code_s->code;type2=code_s->type;//disassy(code2,0);
            if (type1 < type2) {
                push(code1,(void*)conv_op[type1][type2]);
                ret_obj=type2;
            } else if (type1>type2) {
                push(code2,(void*)conv_op[type2][type1]);
                ret_obj=type1;
            } else ret_obj=type1;
            //printf("%d\n",ret_obj);
            code=vector_append(code1,code2);//disassy(code,0,stdin);
            for(i=0;i<9;i++) {
                if (op2_1[i]==(int)(long)vector_ref(a->table,0)) break;
            }
            if (i>=9) {printf("illegal 2oprand\n");return NULL;}
            push(code,(void*)(long)op2_2[ret_obj][i]);
            return new_code(code,ret_obj);
        case AST_1OP: // AST_1OP [op_type,AST_EXPR]
            code_s = codegen((ast*)vector_ref(a->table,1),env,FALSE);
            code=code_s->code;ret_obj=code_s->type;
            for(i=0;i<3;i++) {
                if (op1_1[i]==(int)(long)vector_ref(a->table,0)) break;
            }
            if (type2=op1_2[type1][i]) {printf("syntax Error:operator is not supported\n");return NULL;}
            push(code,(void*)(long)type2);
            return new_code(code,type2);
        case AST_VREF:  // AST_VREF [AST_vect, AST_expr_list[i1,i2,...]]
                        //           <0>                     <1,0>,<1,1>,
            code_s = codegen(((ast*)vector_ref(a->table,0)), env,FALSE);
            code=code_s->code;type1=code_s->type;
            if (type1 != OBJ_VECT) {printf("Syntax Error:must be vector!\n");return NULL;}
            code_s = codegen((ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,0), env,FALSE);
            code1=code_s->code;
            code = vector_append(code,code1);
            push(code,(void*)REF);
            return new_code(code,OBJ_GEN);
        case AST_VAR:   // AST_VAR [var_symbol]
            _pos=var_location((Symbol*)vector_ref(a->table,0),env);
            pos=(Vector*)vector_ref(_pos,0);type1=(obj_type)vector_ref(_pos,1);
            if (pos) {push(code,(void*)LD);push(code,(void*)pos);}
            else {push(code,(void*)LDG);push(code,(void*)vector_ref(a->table,0));}
            // ... constant macro ...
            return new_code(code,type1);
        case AST_LIT:   // AST_LIT [lit_type,lit_symbol]
            //printf("###\n");
            lit_type=(tokentype)vector_ref(a->table,0);
            str_symbol=(Symbol*)vector_ref(a->table,1);
            //printf("!!!\n");
            push(code,(void*)LDC);
            switch(lit_type) {
                case TOKEN_NONE:
                    push(code,(void*)0);
                    return new_code(code,OBJ_NONE);
                case TOKEN_INT:
                    sscanf(str_symbol->_table,"%ld",&int_num);
                    push(code,(void*)int_num);
                    //push(code,(void*)newINT(int_num));
                    return new_code(code,OBJ_INT);
                case TOKEN_LINT:
                    z = (mpz_ptr)malloc(sizeof(MP_INT));
                    mpz_set_str(z,str_symbol->_table,10);
                    push(code,(void*)z);//printf("%s\n",objtype2str(OBJ_LINT,(void*)z));
                    return new_code(code,OBJ_LINT);
                case TOKEN_RAT:
                    q = (mpq_ptr)malloc(sizeof(MP_RAT));
                    mpq_init(q);mpq_set_str(q,str_symbol->_table,10);mpq_canonicalize(q);
                    push(code,(void*)q);
                    return new_code(code,OBJ_RAT);
                case TOKEN_STR:
                    push(code,(void*)vector_ref(a->table,1));
                    return new_code(code,OBJ_SYM);
                case TOKEN_FLT: 
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%lf",fl_num_p);
                    push(code,(void*)fl_num_p);
                    //push(code,(void*)newFLT(fl_num));
                    return new_code(code,OBJ_FLT);
                case TOKEN_EFLT:
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%le",fl_num_p);
                    push(code,(void*)fl_num_p);
                    //push(code,(void*)newFLT(fl_num));
                    return new_code(code,OBJ_FLT);
            }
        case AST_VECT:  // AST_VECT [AST_expr_list [AST_v1,AST_v2,...]]
                        //                          <0,0>  <0,1> ...
            n=((ast*)vector_ref(a->table,0))->table->_sp;//printf("%d\n",n);
            for(i=0;i<n;i++) {
                //code=vector_append(code,codegen(vector_ref(((ast*)vector_ref(a->table,0))->table,i),env,FALSE));
                code_s=codegen(vector_ref(((ast*)vector_ref(a->table,0))->table,i),env,FALSE);
                code1=code_s->code;type1=code_s->type;
                if (type1 != OBJ_GEN) push(code1,(void*)conv_op[type1][OBJ_GEN]);
                code=vector_append(code,code1);
            }
            push(code,(void*)VEC);push(code,(void*)(long)n);
            // 
            return new_code(code,OBJ_VECT);
    } 
}
/*
Vector * codegen(ast * a, Vector * env, int tail) {
    Vector * code = vector_init(10), *code1, *code2,*v,*v1,*v2,*v3,*a_arg_v,*d_arg_v,*pos,*args,*v_expr_body;
    code_ret* code_s=(code_ret*)malloc(sizeof(code_ret));
    code_s->code=code;code_s->type=OBJ_NONE;
    ast * a1,*a2,*ast_list;
    int i,j,n,*tp,dcl_flg; 
    long int_num;
    double fl_num,*fl_num_p;
    tokentype lit_type;
    Symbol*str_symbol;
    switch(a->type) {
        case AST_ML:    //AST_ML [AST_expr_list [AST_1,AST_2,...]]
                        //                       <0,0> <0,1>
            dcl_flg = FALSE;
            ast_list=(ast*)vector_ref(a->table,0);//ast_print(ast_list,0);
            a_arg_v=vector_init(3);d_arg_v=vector_init(3);v_expr_body=vector_init(3);
            for(i=0;i<ast_list->table->_sp;i++) {
                a1=(ast*)vector_ref(ast_list->table,i);//ast_print(a1,0);
                if (a1->type==AST_DCL) {
                    dcl_flg=TRUE;
                    for(j=0;j<((ast*)vector_ref(a1->table,0))->table->_sp;j++) {
                        a2 = (ast*)vector_ref(((ast*)vector_ref(a1->table,0))->table,j);//ast_print(a2,0);
                        if (a2->type==AST_VAR) {                                        // a2:AST_VAR [symbol_var_name_]
                            v=vector_init(2);
                            push(v,(void*)TOKEN_NONE);push(v,(void*)NULL);
                            push(a_arg_v,new_ast(AST_LIT,OBJ_NONE,v));                           // a_arg_v:actual arg list
                            push(d_arg_v,(void*)a2);                                    // d_arg_v:dummy arg list
                        } else if (a2->type==AST_SET &&                                 // a2: AST_SET [set_type, AST_VAR [var_name], expr_ast]
                                    ((ast*)vector_ref(a2->table,1))->type==AST_VAR) {   //                        <1>                 <2>
                            push(a_arg_v,(void*)vector_ref(a2->table,2));               // a_arg_v:actual arg list
                            push(d_arg_v,(void*)vector_ref(a2->table,1));               // d_arg_v:dummy arg list
                        } else {
                            printf("Syntax error :decliation in ml_expr\n");
                            return NULL;
                        }
                    }
                } else {//printf("!!!\n");
                    if (i==ast_list->table->_sp-1) {
                        code=vector_append(code,codegen(a1,env,tail));//disassy(code,0);
                        push(v_expr_body,(void*)a1);//ast_print(a1,0);
                    } else {
                        code=vector_append(code,codegen(a1,env,FALSE));push(code,(void*)DROP);//disassy(code,0);
                        push(v_expr_body,(void*)a1);//ast_print(a1,0);
                    }
                }
            }
            if (dcl_flg==FALSE) {
                return code;
            } else {
                v1=vector_init(2);v2=vector_init(1);
                push(v1,(void*)new_ast(AST_EXP_LIST,OBJ_NONE, d_arg_v));//ast_print(new_ast(AST_EXP_LIST,OBJ_NONE,d_arg_v),0);//dummy arg list
                //push(v2,new_ast(AST_EXP_LIST,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v_expr_body));
                push(v2,new_ast(AST_EXP_LIST,OBJ_NONE,v_expr_body));
                //push(v1,(void*)new_ast(AST_ML,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v2));//ast_print(new_ast(AST_ML,v5),0) ;      // v3:[AST_EXP_LIST,AST_ML]
                push(v1,(void*)new_ast(AST_ML,OBJ_NONE,v2));//ast_print(new_ast(AST_ML,OBJ_NONE,v2),0) ;      // v3:[AST_EXP_LIST,AST_ML]
                //a1=new_ast(AST_LAMBDA,((ast*)vector_ref(v_expr_body,v_expr_body->_sp-1))->o_type,v1);ast_print(a1,0);
                a1=new_ast(AST_LAMBDA,OBJ_NONE,v1);//ast_print(a1,0);
                //
                v3=vector_init(3);
                push(v3,(void*)a1);
                push(v3,(void*)new_ast(AST_EXP_LIST,OBJ_NONE,a_arg_v));   // actual arg list
                a2=new_ast(AST_FCALL,a1->o_type,v3);//ast_print(a2,0);                   // AST_FCALL [AST_LAMBDA [AST_EXP_LIST [..],AST_ML [...]],AST_EXP_LIST [...]]
                return codegen(a2,env,tail);
            }
        case AST_IF:    // AST_IF,[cond_expr,true_expr,false_expr]
            if (tail) { // -> cond_code TSEL true_code+RTN false_code+RTN
                code = codegen(vector_ref(a -> table, 0),env,FALSE);                                // make cond_code 
                code1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)RTN);            // make true_code
                code2 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)RTN);            // make false_code
                push(code, (void * )TSEL); push(code ,(void*)code1); push(code,(void*)code2);       // push TSEL and true_code,false_code
            } else {    // -> cond_code SEL true_code+JOIN false_code+JOIN
                code = codegen(vector_ref(a -> table, 0),env,FALSE);
                code1 = codegen(vector_ref(a->table,1),env,TRUE);push(code1,(void*)JOIN); 
                code2 = codegen(vector_ref(a->table,2),env,TRUE);push(code2,(void*)JOIN); 
                push(code, (void * )SEL); push(code,(void*)code1); push(code,(void*)code2);
            }
            return code;
        case AST_SET:// AST_SET [set_type, AST_left_expr, AST_right_expr]
                switch(((ast*)vector_ref(a->table,1))->type) {
                    case AST_VREF:  // AST_SET [set_type, AST_VREF [vect_expr,index] ], right_expr]
                                    //          <0,0>               <1,0>     <1,1>    <2>
                                    // -> right_code vect_name_code index_code VSET
                        code=codegen(vector_ref(a->table,2),env,FALSE);
                        code1=codegen(vector_ref(a->table,1),env,FALSE);vector_set(code1,code1->_sp-1,(void*)VSET);
                        return vector_append(code,code1);
                    case AST_FCALL: // AST_SET [set_type,AST_FCALL [expr_name , expr_list],right_expr]
                                    //          <0,0>              <1,0>        <1,1>      <2>
                        a1=(ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,0);
                        v1=vector_init(2);
                        push(v1,(void*)(ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,1));//push expr_list
                        push(v1,(void*)vector_ref(a->table,2));
                        a2=new_ast(AST_LAMBDA,((ast*)vector_ref(a->table,2))->o_type,v1);
                        v2=vector_init(2);push(v2,(void*)(long)'=');
                        push(v2,(void*)a1);push(v2,(void*)a2);
                        return codegen(new_ast(AST_SET,a2->o_type,v2),env,FALSE);
                    case AST_VAR:   // AST_SET [set_type, AST_VAR [var_name], right_expr]
                                    //          <0,0>             <1,0>       <2>
                        pos=var_location((Symbol*)vector_ref(((ast*)vector_ref(a->table,1))->table,0),env);
                        code=codegen((ast*)vector_ref(a->table,2),env,FALSE);
                        if (pos) {
                            push(code,(void*)SET);push(code,(void*)pos);
                        } else {
                            push(code,(void*)GSET);push(code,(void*)vector_ref(((ast*)vector_ref(a->table,1))->table,0));
                        }
                        return code;
                    default:printf("jhdjadjaw4yy87wfhwj\n");
                }
        case AST_LAMBDA:    // AST_LAMBDA [AST_EXP_LIST [expr,   exp,   ...]], body_expr]
                            //                           <0,0,0>,<0,0,1>,...   <1>
            args=vector_init(3);
            a1=(ast*)vector_ref(a->table,0);    //expr_list
            for(i=0;i<a1->table->_sp;i++) {
                a2=(ast*)vector_ref(a1->table,i);
                if (a2->type==AST_VAR) {
                    push(args,(void*)vector_ref(a2->table,0));
                } else {printf("illegal argment!\n");}
            } //for(i=0;i<args->_sp;i++) printf("%s\t",((Symbol*)vector_ref(args,i))->_table);printf("\n");
            if (a1->type==AST_EXP_LIST_DOTS) push(args,(void*)new_symbol("..",3));
            push(env,(void*)args);
            code1=codegen((ast*)vector_ref(a->table,1),env,TRUE);push(code1,(void*)RTN);
            push(code,(void*)LDF);push(code,(void*)code1);
            pop(env);// !!don't forget!!!
            return code;
        case AST_FCALL:     // AST_FCALL [AST_NAME,[AST_EXP_LIST [AST,AST,...]]]
                            //            <0>                     <1,0>,<1,1>...
            // ... macro function ...
            a1=(ast*)vector_ref(a->table,1);
            if (a1->type==AST_EXP_LIST_DOTS) {                      // if expr_list_dots -> apply
                v1=vector_init(1+a1->table->_sp);
                push(v1,(void*)vector_ref(a->table,0));
                for(i=0;i<a1->table->_sp;i++) {
                    push(v1,(void*)vector_ref(a1->table,i));
                }
                v2=vector_init(1);
                push(v2,(void*)new_ast(AST_EXP_LIST_DOTS,((ast*)vector_ref(a1->table,a1->table->_sp-1))->o_type,v1));
                return codegen(new_ast(AST_APPLY,((ast*)vector_ref(a1->table,a1->table->_sp-1))->o_type,v2),env,tail);     // AST_APPLY [AST_EXP_LIST [expr0,expr1,...]]
            }
                                                                    // general case
            n = ((ast*)vector_ref(a->table,1))->table->_sp;         // no. of expr_lists
            for(i=0;i<n;i++) {
                code=vector_append(code,codegen((ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,i),env,FALSE));
            }
            code = vector_append(code, codegen((ast*)vector_ref(a->table,0),env,FALSE));    // append Function name % expr_list
            push(code, tail ? (void*)TCALL : (void*)CALL);
            push(code, (void*)(long)n);
            return code;
        case AST_APPLY: // AST_APPLY [AST_EXP_LIST [ast1,ast2,...]] 
            n=((ast*)vector_ref(a->table,0))->table->_sp;//printf("%d\n",n);
            for(i=0;i<n;i++) {
                code = vector_append(code,codegen((ast*)vector_ref(((ast*)vector_ref(a->table,0))->table,i),env,FALSE));//disassy(code,0);
            }
            if (tail) {
                push(code, (void*)TAPL);push(code, (void*)(long)n);
            } else {
                push(code, (void*)APL);push(code, (void*)(long)n);
            }
            return code;
        case AST_2OP:   // AST_2OP [op_type,AST_L_EXPR,AST_R_EXPR]
            code1 = codegen((ast*)vector_ref(a->table,1),env,FALSE);//disassy(code1,0);
            code2 = codegen((ast*)vector_ref(a->table,2),env,FALSE);//disassy(code2,0);
            code=vector_append(code1,code2);//disassy(code,0);
            for(i=0;i<9;i++) {
                if (op2_1[i]==(int)(long)vector_ref(a->table,0)) break;
            }
            if (i>=9) {printf("illegal 2oprand\n");return NULL;}
            push(code,(void*)(long)op2_2[i]);
            return code;
        case AST_1OP: // AST_1OP [op_type,AST_EXPR]
            code = codegen((ast*)vector_ref(a->table,1),env,FALSE);
            for(i=0;i<3;i++) {
                if (op1_1[i]==(int)(long)vector_ref(a->table,0)) break;
            }
            push(code,(void*)(long)op1_2[i]);
            return code;
        case AST_VREF:  // AST_VREF [AST_vect, AST_expr_list[i1,i2,...]]
                        //           <0>                     <1,0>,<1,1>,
            code = codegen(((ast*)vector_ref(a->table,0)), env,FALSE);
            code = vector_append(code,codegen((ast*)vector_ref(((ast*)vector_ref(a->table,1))->table,0), env,FALSE));
            push(code,(void*)REF);
            return code;
        case AST_VAR:   // AST_VAR [var_symbol]
            pos=var_location((Symbol*)vector_ref(a->table,0),env);
            if (pos) {push(code,(void*)LD);push(code,(void*)pos);}
            else {push(code,(void*)LDG);push(code,(void*)vector_ref(a->table,0));}
            // ... constant macro ...
            return code;
        case AST_LIT:   // AST_LIT [lit_type,lit_symbol]
            lit_type=(tokentype)vector_ref(a->table,0);
            str_symbol=(Symbol*)vector_ref(a->table,1);

            push(code,(void*)LDC);
            switch(lit_type) {
                case TOKEN_NONE:
                    push(code,(void*)0);
                    return code;
                case TOKEN_INT:
                    sscanf(str_symbol->_table,"%ld",&int_num);
                    push(code,(void*)int_num);
                    //push(code,(void*)newINT(int_num));
                    return code;
                case TOKEN_STR:
                    push(code,(void*)vector_ref(a->table,1));
                    return code;
                case TOKEN_FLT: 
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%lf",fl_num_p);
                    push(code,(void*)fl_num_p);
                    //push(code,(void*)newFLT(fl_num));
                    return code;
                case TOKEN_EFLT:
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%le",fl_num_p);
                    push(code,(void*)fl_num_p);
                    //push(code,(void*)newFLT(fl_num));
                    return code;
            }
        case AST_VECT:  // AST_VECT [AST_expr_list [AST_v1,AST_v2,...]]
                        //                          <0,0>  <0,1> ...
            n=((ast*)vector_ref(a->table,0))->table->_sp;//printf("%d\n",n);
            for(i=0;i<n;i++) {
                code=vector_append(code,codegen(vector_ref(((ast*)vector_ref(a->table,0))->table,i),env,FALSE));
            }
            push(code,(void*)VEC);push(code,(void*)(long)n);
            // 
            return code;
    } 
}
*/
char * code_name[] = 
    {"STOP",  "LDC",  "LD",  "ADD", "CALL", "RTN", "SEL", "JOIN", "LDF", "SET", "LEQ", "LDG", "GSET", "SUB",
     "DEC",   "TCALL","TSEL","DROP","EQ",   "INC", "MUL", "DIV",  "VEC", "REF", "VSET","HASH","LDH",  "HSET",
     "VPUSH", "VPOP", "LADD","LSUB","LMUL", "ITOL","LPR", "PCALL","LDM", "DUP", "SWAP","ROT", "_2ROT","CALLS",
     "TCALLS","RTNS", "LDP", "LDL", "FADD", "FSUB","FMUL","FDIV", "FPR", "ITOF","LCPY","OADD","OSUB", "OMUL",
     "ODIV",  "OEQ",  "OLEQ","ITOO","OPR",  "ODEC","OINC","IADD", "ISUB","IMUL","IDIV","IEQ", "ILEQ", "IDEC",
     "IINC",  "LTOO", "FTOO","IJTOO","SPR", "LDIV","OLT", "LT"  , "ILT", "GT",  "IGT", "OGT"  "GEQ",  "IGEQ",
     "OGEQ",  "NEG",  "INEG","ONEG", "BNOT","APL", "TAPL","FEQ",  "FLEQ","FGEQ","FLT", "FGT", "LEQ",  "LLEQ",
     "LGEQ",  "LLT",  "LGT", "RADD", "RSUB","RMUL","RDIV","REQ",  "RLEQ","RGEQ","RLT", "RGT", "ITOR", "_ITOF",
     "LTOR",  "LTOF", "RTOF", "RTOO","LTOI","RTOI","RTOL","FTOI", "FTOL","FTOR", "LNEG","RNEG","FNEG","LDEC",
     "LINC",  "$$$" };

void disassy(Vector * code, int indent, FILE*fp) {
    int i; long c; 
    Vector * v; char * s; 
    for(i = 0; i<indent; i ++ ) fprintf(fp,"\t"); 
    fprintf(fp,"[\n"); indent ++ ; 

    while (TRUE) {
        if (is_queu_empty(code)) break;
        c = (long)dequeue(code);//printf("%ld\n",c); 
        for(i= 0; i< indent; i ++ ) fprintf(fp,"\t"); 
        switch(c) {  
            case SEL:   case TSEL:
                fprintf(fp,"%s\n", code_name[c]); 
                disassy((Vector * ) dequeue(code), indent ,fp); 
                disassy((Vector * ) dequeue(code), indent, fp); 
                break; 
            case LDF:   case LDP:
                fprintf(fp,"%s\n", code_name[c]); 
                disassy((Vector *)dequeue(code), indent,fp ); 
                break;
            case LD:    case SET:
                v = (Vector * )dequeue(code); 
                fprintf(fp,"%s\t(%ld %ld)\n", code_name[c], (long)vector_ref(v, 0), (long)vector_ref(v, 1));  
                break; 
            case LDG:   case GSET: 
                s = ((Symbol * )dequeue(code)) -> _table;
                fprintf(fp,"%s\t%s\n", code_name[c], s);
                break;   
            default:
                if (op_size[c] == 0) printf("%s\n", code_name[c]);
                else if (op_size[c] == 1) printf("%s\t%ld\n", code_name[c], (long)dequeue(code)); 
                else printf("Unknkown Command %s\n", (char * )c); 
        }
    }
    indent--;
    for(i= 0; i< indent; i ++ ) printf("\t"); 
    fprintf(fp,"]\n"); 
    code ->_cp = 0;  
} 

extern Vector*tokenbuff;

void * _realloc(void * ptr, size_t old_size, size_t new_size) {
    return GC_realloc(ptr, new_size); 
}

int main(int argc, char*argv[]) {
    void* value;
    ast *a;
    printf("PURE REPL Version 0.02\nCopyright 2021.04.02- M.Taniguro\n\n>>");
    Stream *S;
    int token_p;
    Vector*env;
    Vector*code;
    code_ret *code_s;
    obj_type type; 
    mp_set_memory_functions((void *)GC_malloc, (void * )_realloc, (void * ) GC_free);

    Vector * t; 
    Vector * Stack = vector_init(500000); 
    //Vector * C, * CC ; 
    Vector * Ret = vector_init(500); 
    Vector * Env = vector_init(50); 
    Hash * G = Hash_init(128); // must be 2^n 
    if (argc<=1) S=new_stream(stdin);
    else {
        FILE*fp = fopen(argv[1], "r");
        if (fp == NULL) {printf("file %s doesn't exist\n", argv[1]); return  - 1; }
        S = new_stream(fp); 
    }

        tokenbuff=vector_init(100);
    while (TRUE) {
        //tokenbuff=vector_init(100);
        env=vector_init(10);
        //token_p=tokenbuff->_cp;
        //token_print(tokenbuff);
        if ((a=is_expr(S)) && get_token(S)->type==';') {
            ast_print(a,0);
            code_s = codegen(a,env,FALSE);//printf("123\n");
            code=code_s->code;push(code,(void*)STOP);//printf("!!!\n");
            type=code_s->type;            
            disassy(code,0,stdout);
            value = eval(Stack,Env,code,Ret,Env,G);printf("!!!\n");
            printf("%s ok\n>>", objtype2str(type,value));
        } else {
            printf("Not expression!\n");
           // tokenbuff->_cp=token_p;
           tokenbuff=vector_init(100);
        }
        //token_print(tokenbuff); 
        //tokenbuff->_cp=0;tokenbuff->_sp=0;
        if (get_token(S)==NULL) exit(0);
        unget_token(S);
    }

}
