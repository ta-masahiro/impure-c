#include "vector.h"
#include "symbol.h"
#include <float.h>
#include <math.h>

#ifndef OBJECT
#define OBJECT
typedef enum { OBJ_NONE=0, 
    OBJ_INT, OBJ_LINT, OBJ_RAT, OBJ_FLT,OBJ_LFLT,OBJ_GEN,
    OBJ_PFUNC, OBJ_UFUNC, OBJ_CNT,
    OBJ_VECT, OBJ_DICT, OBJ_PAIR,OBJ_SYM,
    OBJ_IO,
} obj_type;

typedef struct object {
    obj_type type;
    union {
        long    intg;
        double  flt;
        void *  ptr;
    } data;
} object;
//
mpz_ptr itol(long n) ;
double  itof(long n) ;
mpf_ptr itolf(long n) ;
long    litoi(mpz_ptr L);
mpq_ptr litor(mpz_ptr L);
double  litof(mpz_ptr L) ;
mpf_ptr litolf(mpz_ptr L) ;
long    rtoi(mpq_ptr Q) ;
mpz_ptr rtoli(mpq_ptr Q) ;
double  rtof(mpq_ptr Q) ;
mpf_ptr rtolf(mpq_ptr Q) ;
long    ftoi(double d) ;
mpz_ptr ftoli(double d) ;
mpf_ptr ftolf(double f) ;
long    lftoi(mpf_ptr F) ;
//
object * newINT(long n) ;
object * newLINT(mpz_ptr L) ;
object * newLINT_i(long n) ;
object * newLINT_s(char * s) ;
object * newRAT(mpq_ptr Q) ;
object * newRAT_i(long i, long j) ;
object * newFLT(double d) ;
object * newLFLT(mpf_ptr F) ;
object * newLFFT_f(double f) ;
object * newVECT(Vector*v);
object * newSTR(Symbol*s);
long obj2int(object*o);
mpz_ptr obj2long(object*o);
mpq_ptr obj2rat(object*o);
double obj2flt(object*o);
//
object * objIADD(long x, long y) ;
object * objISUB(long x, long y) ;
object * objIMUL(long x, long y) ;
object * objIDIV(long x, long y) ;
object * objIMOD(long x, long y) ;
object * objIPOW(long x, long y) ;
object * objLADD(mpz_ptr x, mpz_ptr y) ;
object * objLADD_i(mpz_ptr x, long y) ;
object * objLSUB(mpz_ptr x, mpz_ptr y) ;
object * objLSUB_i(mpz_ptr x, long y) ;
object * objLMUL(mpz_ptr x, mpz_ptr y) ;
object * objLDIV(mpz_ptr x, mpz_ptr y) ;
object * objLMOD(mpz_ptr x, mpz_ptr y) ;
object * objLPOW(mpz_ptr x, long y) ;
object * objRADD(mpq_ptr x, mpq_ptr y);
object * objRSUB(mpq_ptr x, mpq_ptr y) ;
object * objRMUL(mpq_ptr x, mpq_ptr y) ;
object * objRDIV(mpq_ptr x, mpq_ptr y) ;
object * objRMOD(mpq_ptr x, mpq_ptr y) ;
object * objRPOW(mpq_ptr x, long y);
object * objFADD(double x, double y) ;
object * objFSUB(double x, double y) ;
object * objFMUL(double x, double y) ;
object * objFDIV(double x,double y) ;
object * objFMOD(double x,double y);
object * objFPOW(double x,double y);
object * objLFADD(mpf_ptr x, mpf_ptr y) ;
object * objLFMUL(mpf_ptr x, mpf_ptr y) ;
object * objLFSUB(mpf_ptr x, mpf_ptr y) ;
object * objLFDIV(mpf_ptr x, mpf_ptr y) ;
object * objLFMOD(mpf_ptr x, mpf_ptr y) ;
object * objLFPOW_i(mpf_ptr x, long y) ;
int objICMP(long x, long y);
int objLCMP(mpz_ptr x, mpz_ptr y);
int objRCMP(mpq_ptr x, mpq_ptr y);
int objFCMP(double x, double y) ;
int objLFCMP(mpf_ptr x, mpf_ptr y);
//
object * objadd(object * x, object * y);
object * objsub(object * x, object * y);
object * objmul(object * x, object * y);
object * objdiv(object * x, object * y);
object * objmod(object * x, object * y);
object * objpow(object * x, object * y);
object * objor(object*x,object*y);
object * objand(object*x,object*y);
int objcmp(object * x, object * y);
object * objneg(object * x) ;
object * objnot(object * x) ;
object * objabs(object * x) ;
object * objinc(object * x) ;
object * objdec(object * x) ;
object * objsqrt(object * x) ;
int objlt(object*x,object*y);
int objle(object*x,object*y);
int objgt(object*x,object*y);
int objge(object*x,object*y);
int objeq(object*x,object*y);
int objneq(object*x,object*y);
char * objtostr(object * o);
char * objtype2str(obj_type t,void* v);
object * objcpy(object * s);
int objlen(object*o);
object*objref(object*o,long pos);
void objset(object*o,long pos,object*val);
#endif
