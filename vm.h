#include "hash.h"
#include "object.h"
//Symbol*new_symbol(unsigned char*s, unsigned long i);
mpz_ptr new_long();
mpz_ptr new_long_valued(long val);
mpz_ptr new_long_str(char* s);

typedef void*(*Funcpointer)(Vector*);

enum CODE { STOP,  LDC,  LD,   ADD,  CALL, RTN, SEL, JOIN, LDF, SET, LEQ,  LDG,  GSET, SUB,  \
            DEC,   TCALL,TSEL, DROP, EQ,   INC, MUL, DIV,  VEC, REF, VSET, HASH, LDH,  HSET, \
            VPUSH, VPOP, LADD, LSUB, LMUL, ITOL,LPR, PCALL,LDM, DUP, SWAP, ROT, _2ROT, CALLS,\
            TCALLS,RTNS, LDP,  LDL,  FADD, FSUB,FMUL,FDIV ,FPR, ITOF,LCPY, OADD, OSUB, OMUL, \
            ODIV,  OEQ,  OLEQ, ITOO, OPR , ODEC,OINC,IADD, ISUB,IMUL,IDIV, IEQ,  ILEQ, IDEC, \
            IINC,  LTOO, FTOO, IJTOO,SPR,  LDIV,OLT, LT,   ILT ,GT  ,IGT,  OGT,  GEQ,  IGEQ, \
            OGEQ,  NEG,  INEG, ONEG, BNOT, APL, TAPL,FEQ,  FLEQ,FGEQ,FLT,  FGT,  L_EQ, LLEQ, \
            LGEQ,  LLT,  LGT , RADD, RSUB, RMUL,RDIV,REQ,  RLEQ,RGEQ,RLT,  RGT,  ITOR, OTOF, \
            LTOR,  LTOF, RTOF, RTOO ,LTOI, RTOI,RTOL,FTOI, FTOL,FTOR,LNEG, RNEG, FNEG, LINC, \
            LDEC,  NEQ,  INEQ, LNEQ, RNEQ, FNEQ,ONEQ,OTOI, OTOL,OTOR,VTOO, STOO, IPOW, LPOW, \
            RPOW,  FPOW, OPOW, IMOD, LMOD, RMOD,FMOD,OMOD, IBOR,LBOR,OBOR, IBNOT,LBNOT,OBNOT,\
            IBAND, LBAND,OBAND,VLEN, SLEN, OLEN,VAPP,SAPP, VREF,SREF,OREF, SSET, OSET  };

extern int op_size[];
extern char*code_name[];
void * eval(Vector * S, Vector * E, Vector * Code, Vector * R, Vector * EE, Hash * G);