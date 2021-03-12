#include "vm.h"
#include "lexparse.h"

void disassy(Vector*v,int i);

int op2_1[] = {'+', '-', '*', '/', '>', '<', '='*256+'=', '>'*256+'=', '<'*256+'=',0};
int op2_2[] = {ADD, SUB, MUL, DIV, GT, LT, EQ, GEQ, LEQ };
int op1_1[] = {'-', '~', '+'*256+'+', '-'*256+'-',0};
int op1_2[] = {NEG, BNOT,INC,         DEC} ;

Vector * var_location(Symbol * varname, Vector * env) { 
    int i,j;
    Vector * v,*nv;//printf("varname:%s\n",varname->_table); 
    //if (is_stac_empty(env)) return NULL; 
    for(i = 0; i< env->_sp; i ++ ) {
        v = vector_ref(env,env->_sp-i-1);//vector_print(v);
        for (j = 0; j<v -> _sp; j ++ ) {//printf("env%d:%s\n",j,((Symbol*)vector_ref(v,j))->_table);printf("%d\n",symbol_eq(varname,vector_ref(v,j)));
            if (symbol_eq(varname, vector_ref(v, j))) {
                nv = vector_init(2); 
                if (j==v->_sp-2 && strcmp(((Symbol*)vector_ref(v,j+1))->_table,"..")==0) j=-(j+1);
                push(nv, (void * )(long)i); push(nv, (void * )(long)j); 
                return nv; 
            }
        }
    }
    return NULL; 
}

Vector * codegen(ast * a, Vector * env, int tail) {
    Vector * code = vector_init(10), *code1, *code2,*v,*v1,*v2,*v3,*a_arg_v,*d_arg_v,*pos,*args,*v_expr_body;
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
                            push(a_arg_v,new_ast(AST_LIT,v));                           // a_arg_v:actual arg list
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
                push(v1,(void*)new_ast(AST_EXP_LIST,d_arg_v));//ast_print(new_ast(AST_EXP_LIST,v2),0);//dummy arg list
                push(v2,new_ast(AST_EXP_LIST,v_expr_body));
                push(v1,(void*)new_ast(AST_ML,v2));//ast_print(new_ast(AST_ML,v5),0) ;      // v3:[AST_EXP_LIST,AST_ML]
                a1=new_ast(AST_LAMBDA,v1);//ast_print(a1,0);
                //
                v3=vector_init(3);
                push(v3,(void*)a1);
                push(v3,(void*)new_ast(AST_EXP_LIST,a_arg_v));   // actual arg list
                a2=new_ast(AST_FCALL,v3);                   // AST_FCALL [AST_LAMBDA [AST_EXP_LIST [..],AST_ML [...]],AST_EXP_LIST [...]]
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
                        a2=new_ast(AST_LAMBDA,v1);
                        v2=vector_init(2);push(v2,(void*)(long)'=');
                        push(v2,(void*)a1);push(v2,(void*)a2);
                        return codegen(new_ast(AST_SET,v2),env,FALSE);
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
                push(v2,(void*)new_ast(AST_EXP_LIST_DOTS,v1));
                return codegen(new_ast(AST_APPLY,v2),env,tail);     // AST_APPLY [AST_EXP_LIST [expr0,expr1,...]]
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
                    return code;
                case TOKEN_STR:
                    push(code,(void*)vector_ref(a->table,1));
                    return code;
                case TOKEN_FLT: 
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%lf",fl_num_p);
                    push(code,(void*)fl_num_p);
                    return code;
                case TOKEN_EFLT:
                    fl_num_p=(double*)malloc(sizeof(double));
                    sscanf(str_symbol->_table,"%le",fl_num_p);
                    push(code,(void*)fl_num_p);
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

char * code_name[] = 
    {"STOP",  "LDC",  "LD",  "ADD", "CALL", "RTN", "SEL", "JOIN", "LDF", "SET", "LEQ", "LDG", "GSET", "SUB",
     "DEC",   "TCALL","TSEL","DROP","EQ",   "INC", "MUL", "DIV",  "VEC", "REF", "VSET","HASH","LDH",  "HSET",
     "VPUSH", "VPOP", "LADD","LSUB","LMUL", "ITOL","LPR", "PCALL","LDM", "DUP", "SWAP","ROT", "_2ROT","CALLS",
     "TCALLS","RTNS", "LDP", "LDL", "FADD", "FSUB","FMUL","FDIV", "FPR", "ITOF","LCPY","OADD","OSUB", "OMUL",
     "ODIV",  "OEQ",  "OLEQ","ITOO","OPR",  "ODEC","OINC","IADD", "ISUB","IMUL","IDIV","IEQ", "ILEQ", "IDEC",
     "IINC",  "LTOO", "FTOO","IJTOO","SPR", "LDIV","OLT", "LT"  , "ILT", "GT",  "IGT", "OGT"  "GEQ",  "IGEQ",
     "OGEQ",  "NEG",  "INEG","ONEG", "BNOT","APL", "TAPL","$$$" };
/*
int op_size[] = \
          {0,    1,     1,    0,    1,    0,   2,   0,    1,   1,   0,    1,    1,    0,    \
           0,    1,     2,    0,    0,    0,   0,   0,    1,   0,   0,    0,    0,    0,    \
           0,    0,     0,    0,    0,    0,   0,   1,    0,   0,   0,    0,    0,    1,    \
           1,    0,     1,    1,    0,    0,   0,   0,    0,   0,   0 ,   0,    0,    0,    \
           0,    0,     0,    0,    0,    0,   0,   0,    0,   0,   0,    0,    0,    0,    \
           0,    0,     0,    0,    0,    0 ,  0,   0,    0,   0,   0,    0,    0,    0,    \
           0,    0,     0,    0,    0}; 
*/
void disassy(Vector * code, int indent) {
    int i; long c; 
    Vector * v; char * s; 
    for(i = 0; i<indent; i ++ ) printf("\t"); 
    printf("[\n"); indent ++ ; 

    while (TRUE) {
        if (is_queu_empty(code)) break;
        c = (long)dequeue(code);//printf("%ld\n",c); 
        for(i= 0; i< indent; i ++ ) printf("\t"); 
        switch(c) {  
            case SEL:   case TSEL:
                printf("%s\n", code_name[c]); 
                disassy((Vector * ) dequeue(code), indent ); 
                disassy((Vector * ) dequeue(code), indent ); 
                break; 
            case LDF:   case LDP:
                printf("%s\n", code_name[c]); 
                disassy((Vector *)dequeue(code), indent ); 
                break;
            case LD:    case SET:
                v = (Vector * )dequeue(code); 
                printf("%s\t(%ld %ld)\n", code_name[c], (long)vector_ref(v, 0), (long)vector_ref(v, 1));  
                break; 
            case LDG:   case GSET: 
                s = ((Symbol * )dequeue(code)) -> _table;
                printf("%s\t%s\n", code_name[c], s);
                break;   
            default:
                if (op_size[c] == 0) printf("%s\n", code_name[c]);
                else if (op_size[c] == 1) printf("%s\t%ld\n", code_name[c], (long)dequeue(code)); 
                else printf("Unknkown Command %s\n", (char * )c); 
        }
    }
    indent--;
    for(i= 0; i< indent; i ++ ) printf("\t"); 
    printf("]\n"); 
    code ->_cp = 0;  
} 

extern Vector*tokenbuff;

void * _realloc(void * ptr, size_t old_size, size_t new_size) {
    return GC_realloc(ptr, new_size); 
}

int main(int argc, char argv[]) {
    ast *a;
    printf("PURE REPL Version 0.01\nCopyright 2021.03.05- M.Taniguro\n\n>>");
    Stream *S=new_stream(stdin);
    int token_p;
    Vector*env;
    Vector*code;
    
    mp_set_memory_functions((void *)GC_malloc, (void * )_realloc, (void * ) GC_free);

    Vector * t; 
    Vector * Stack = vector_init(500000); 
    //Vector * C, * CC ; 
    Vector * Ret = vector_init(500); 
    Vector * Env = vector_init(50); 
    Hash * G = Hash_init(128); // must be 2^n 
    while (TRUE) {
        tokenbuff=vector_init(100);
        env=vector_init(10);
        //token_p=tokenbuff->_cp;
        //token_print(tokenbuff);
        if ((a=is_expr(S)) && get_token(S)->type==';') {
            ast_print(a,0);
            code=codegen(a,env,FALSE);push(code,(void*)STOP);
            disassy(code,0);
            printf("%ld ok\n>>",(long)eval(Stack,Env,code,Ret,Env,G));
        } else {
            printf("Not expression!\n");
           // tokenbuff->_cp=token_p;
           //drop_token(S);
        } 
        //tokenbuff->_cp=0;tokenbuff->_sp=0;
    }

}
