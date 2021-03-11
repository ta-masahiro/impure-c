; ModuleID = 'vm.c'
source_filename = "vm.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Vector = type { i32, i8**, i32, i32 }
%struct.Hash = type { %struct.Data*, i64, i64, i64 }
%struct.Data = type { %struct.Symbol*, i8* }
%struct.Symbol = type { i64, i8* }
%struct.__mpz_struct = type { i32, i32, i64* }
%struct.object = type { i32, %union.anon }
%union.anon = type { i64 }

@op_size = global [79 x i32] [i32 0, i32 1, i32 1, i32 0, i32 1, i32 0, i32 2, i32 0, i32 1, i32 1, i32 0, i32 1, i32 1, i32 0, i32 0, i32 1, i32 2, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 1, i32 1, i32 0, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0], align 16
@eval.table = internal global [79 x i8*] [i8* blockaddress(@eval, %63), i8* blockaddress(@eval, %68), i8* blockaddress(@eval, %74), i8* blockaddress(@eval, %209), i8* blockaddress(@eval, %677), i8* blockaddress(@eval, %835), i8* blockaddress(@eval, %844), i8* blockaddress(@eval, %891), i8* blockaddress(@eval, %897), i8* blockaddress(@eval, %147), i8* blockaddress(@eval, %634), i8* blockaddress(@eval, %117), i8* blockaddress(@eval, %181), i8* blockaddress(@eval, %349), i8* blockaddress(@eval, %411), i8* blockaddress(@eval, %736), i8* blockaddress(@eval, %870), i8* blockaddress(@eval, %1058), i8* blockaddress(@eval, %606), i8* blockaddress(@eval, %446), i8* blockaddress(@eval, %477), i8* blockaddress(@eval, %541), i8* blockaddress(@eval, %914), i8* blockaddress(@eval, %956), i8* blockaddress(@eval, %969), i8* blockaddress(@eval, %987), i8* blockaddress(@eval, %998), i8* blockaddress(@eval, %1021), i8* blockaddress(@eval, %1038), i8* blockaddress(@eval, %1050), i8* blockaddress(@eval, %242), i8* blockaddress(@eval, %383), i8* blockaddress(@eval, %510), i8* blockaddress(@eval, %272), i8* blockaddress(@eval, %1079), i8* blockaddress(@eval, %789), i8* blockaddress(@eval, %137), i8* blockaddress(@eval, %1119), i8* blockaddress(@eval, %1133), i8* blockaddress(@eval, %1175), i8* blockaddress(@eval, %1236), i8* blockaddress(@eval, %1297), i8* blockaddress(@eval, %1327), i8* blockaddress(@eval, %1342), i8* blockaddress(@eval, %1369), i8* blockaddress(@eval, %1375), i8* blockaddress(@eval, %222), i8* blockaddress(@eval, %363), i8* blockaddress(@eval, %490), i8* blockaddress(@eval, %555), i8* blockaddress(@eval, %1063), i8* blockaddress(@eval, %284), i8* blockaddress(@eval, %260), i8* blockaddress(@eval, %197), i8* blockaddress(@eval, %337), i8* blockaddress(@eval, %465), i8* blockaddress(@eval, %528), i8* blockaddress(@eval, %593), i8* blockaddress(@eval, %621), i8* blockaddress(@eval, %297), i8* blockaddress(@eval, %1103), i8* blockaddress(@eval, %437), i8* blockaddress(@eval, %456), i8* blockaddress(@eval, %210), i8* blockaddress(@eval, %350), i8* blockaddress(@eval, %478), i8* blockaddress(@eval, %542), i8* blockaddress(@eval, %607), i8* blockaddress(@eval, %635), i8* blockaddress(@eval, %412), i8* blockaddress(@eval, %447), i8* blockaddress(@eval, %306), i8* blockaddress(@eval, %315), i8* blockaddress(@eval, %325), i8* blockaddress(@eval, %1094), i8* blockaddress(@eval, %575), i8* blockaddress(@eval, %649), i8* blockaddress(@eval, %662), i8* blockaddress(@eval, %663)], align 16
@.str = private unnamed_addr constant [17 x i8] c"Unknown Key: %s\0A\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"CL\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"%Zd\0A\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define %struct.Vector* @tosqs(%struct.Vector*, i8**) #0 {
  %3 = alloca %struct.Vector*, align 8
  %4 = alloca i8**, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.Vector*, align 8
  store %struct.Vector* %0, %struct.Vector** %3, align 8
  store i8** %1, i8*** %4, align 8
  %7 = load %struct.Vector*, %struct.Vector** %3, align 8
  %8 = call %struct.Vector* @vector_copy0(%struct.Vector* %7)
  store %struct.Vector* %8, %struct.Vector** %6, align 8
  br label %9

; <label>:9:                                      ; preds = %99, %2
  %10 = load %struct.Vector*, %struct.Vector** %3, align 8
  %11 = getelementptr inbounds %struct.Vector, %struct.Vector* %10, i32 0, i32 2
  %12 = load i32, i32* %11, align 8
  %13 = load %struct.Vector*, %struct.Vector** %3, align 8
  %14 = getelementptr inbounds %struct.Vector, %struct.Vector* %13, i32 0, i32 3
  %15 = load i32, i32* %14, align 4
  %16 = icmp slt i32 %12, %15
  br i1 %16, label %17, label %100

; <label>:17:                                     ; preds = %9
  %18 = load %struct.Vector*, %struct.Vector** %3, align 8
  %19 = call i8* @dequeue(%struct.Vector* %18)
  %20 = ptrtoint i8* %19 to i32
  store i32 %20, i32* %5, align 4
  %21 = load %struct.Vector*, %struct.Vector** %6, align 8
  %22 = load %struct.Vector*, %struct.Vector** %6, align 8
  %23 = getelementptr inbounds %struct.Vector, %struct.Vector* %22, i32 0, i32 2
  %24 = load i32, i32* %23, align 8
  %25 = add nsw i32 %24, 1
  store i32 %25, i32* %23, align 8
  %26 = load i8**, i8*** %4, align 8
  %27 = load i32, i32* %5, align 4
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds i8*, i8** %26, i64 %28
  %30 = load i8*, i8** %29, align 8
  %31 = bitcast i8* %30 to i8**
  call void @vector_set(%struct.Vector* %21, i32 %24, i8** %31)
  %32 = load i32, i32* %5, align 4
  %33 = icmp eq i32 %32, 8
  br i1 %33, label %37, label %34

; <label>:34:                                     ; preds = %17
  %35 = load i32, i32* %5, align 4
  %36 = icmp eq i32 %35, 44
  br i1 %36, label %37, label %50

; <label>:37:                                     ; preds = %34, %17
  %38 = load %struct.Vector*, %struct.Vector** %6, align 8
  %39 = load %struct.Vector*, %struct.Vector** %6, align 8
  %40 = getelementptr inbounds %struct.Vector, %struct.Vector* %39, i32 0, i32 2
  %41 = load i32, i32* %40, align 8
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %40, align 8
  %43 = load %struct.Vector*, %struct.Vector** %3, align 8
  %44 = call i8* @dequeue(%struct.Vector* %43)
  %45 = bitcast i8* %44 to %struct.Vector*
  %46 = load i8**, i8*** %4, align 8
  %47 = call %struct.Vector* @tosqs(%struct.Vector* %45, i8** %46)
  %48 = bitcast %struct.Vector* %47 to i8*
  %49 = bitcast i8* %48 to i8**
  call void @vector_set(%struct.Vector* %38, i32 %41, i8** %49)
  br label %99

; <label>:50:                                     ; preds = %34
  %51 = load i32, i32* %5, align 4
  %52 = icmp eq i32 %51, 6
  br i1 %52, label %56, label %53

; <label>:53:                                     ; preds = %50
  %54 = load i32, i32* %5, align 4
  %55 = icmp eq i32 %54, 16
  br i1 %55, label %56, label %81

; <label>:56:                                     ; preds = %53, %50
  %57 = load %struct.Vector*, %struct.Vector** %6, align 8
  %58 = load %struct.Vector*, %struct.Vector** %6, align 8
  %59 = getelementptr inbounds %struct.Vector, %struct.Vector* %58, i32 0, i32 2
  %60 = load i32, i32* %59, align 8
  %61 = add nsw i32 %60, 1
  store i32 %61, i32* %59, align 8
  %62 = load %struct.Vector*, %struct.Vector** %3, align 8
  %63 = call i8* @dequeue(%struct.Vector* %62)
  %64 = bitcast i8* %63 to %struct.Vector*
  %65 = load i8**, i8*** %4, align 8
  %66 = call %struct.Vector* @tosqs(%struct.Vector* %64, i8** %65)
  %67 = bitcast %struct.Vector* %66 to i8*
  %68 = bitcast i8* %67 to i8**
  call void @vector_set(%struct.Vector* %57, i32 %60, i8** %68)
  %69 = load %struct.Vector*, %struct.Vector** %6, align 8
  %70 = load %struct.Vector*, %struct.Vector** %6, align 8
  %71 = getelementptr inbounds %struct.Vector, %struct.Vector* %70, i32 0, i32 2
  %72 = load i32, i32* %71, align 8
  %73 = add nsw i32 %72, 1
  store i32 %73, i32* %71, align 8
  %74 = load %struct.Vector*, %struct.Vector** %3, align 8
  %75 = call i8* @dequeue(%struct.Vector* %74)
  %76 = bitcast i8* %75 to %struct.Vector*
  %77 = load i8**, i8*** %4, align 8
  %78 = call %struct.Vector* @tosqs(%struct.Vector* %76, i8** %77)
  %79 = bitcast %struct.Vector* %78 to i8*
  %80 = bitcast i8* %79 to i8**
  call void @vector_set(%struct.Vector* %69, i32 %72, i8** %80)
  br label %98

; <label>:81:                                     ; preds = %53
  %82 = load i32, i32* %5, align 4
  %83 = zext i32 %82 to i64
  %84 = getelementptr inbounds [79 x i32], [79 x i32]* @op_size, i64 0, i64 %83
  %85 = load i32, i32* %84, align 4
  %86 = load %struct.Vector*, %struct.Vector** %3, align 8
  %87 = getelementptr inbounds %struct.Vector, %struct.Vector* %86, i32 0, i32 2
  %88 = load i32, i32* %87, align 8
  %89 = add nsw i32 %88, %85
  store i32 %89, i32* %87, align 8
  %90 = load i32, i32* %5, align 4
  %91 = zext i32 %90 to i64
  %92 = getelementptr inbounds [79 x i32], [79 x i32]* @op_size, i64 0, i64 %91
  %93 = load i32, i32* %92, align 4
  %94 = load %struct.Vector*, %struct.Vector** %6, align 8
  %95 = getelementptr inbounds %struct.Vector, %struct.Vector* %94, i32 0, i32 2
  %96 = load i32, i32* %95, align 8
  %97 = add nsw i32 %96, %93
  store i32 %97, i32* %95, align 8
  br label %98

; <label>:98:                                     ; preds = %81, %56
  br label %99

; <label>:99:                                     ; preds = %98, %37
  br label %9

; <label>:100:                                    ; preds = %9
  %101 = load %struct.Vector*, %struct.Vector** %6, align 8
  %102 = getelementptr inbounds %struct.Vector, %struct.Vector* %101, i32 0, i32 2
  store i32 0, i32* %102, align 8
  %103 = load %struct.Vector*, %struct.Vector** %6, align 8
  ret %struct.Vector* %103
}

declare %struct.Vector* @vector_copy0(%struct.Vector*) #1

declare i8* @dequeue(%struct.Vector*) #1

declare void @vector_set(%struct.Vector*, i32, i8**) #1

; Function Attrs: noinline nounwind optnone uwtable
define i8* @eval(%struct.Vector*, %struct.Vector*, %struct.Vector*, %struct.Vector*, %struct.Vector*, %struct.Hash*) #0 {
  %7 = alloca %struct.Vector*, align 8
  %8 = alloca %struct.Vector*, align 8
  %9 = alloca %struct.Vector*, align 8
  %10 = alloca %struct.Vector*, align 8
  %11 = alloca %struct.Vector*, align 8
  %12 = alloca %struct.Hash*, align 8
  %13 = alloca %struct.Symbol*, align 8
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i64, align 8
  %18 = alloca i64, align 8
  %19 = alloca i64, align 8
  %20 = alloca i64, align 8
  %21 = alloca %struct.Vector*, align 8
  %22 = alloca %struct.Vector*, align 8
  %23 = alloca %struct.Vector*, align 8
  %24 = alloca %struct.Vector*, align 8
  %25 = alloca %struct.Vector*, align 8
  %26 = alloca %struct.Vector*, align 8
  %27 = alloca %struct.Vector*, align 8
  %28 = alloca %struct.Vector*, align 8
  %29 = alloca %struct.Vector*, align 8
  %30 = alloca %struct.Vector*, align 8
  %31 = alloca i8**, align 8
  %32 = alloca i8*, align 8
  %33 = alloca i8* (%struct.Vector*)*, align 8
  %34 = alloca %struct.Hash*, align 8
  %35 = alloca %struct.__mpz_struct*, align 8
  %36 = alloca %struct.__mpz_struct*, align 8
  %37 = alloca %struct.__mpz_struct*, align 8
  %38 = alloca %struct.__mpz_struct*, align 8
  %39 = alloca i32, align 4
  %40 = alloca %struct.Vector*, align 8
  %41 = alloca %struct.Vector*, align 8
  %42 = alloca double*, align 8
  %43 = alloca double*, align 8
  %44 = alloca double*, align 8
  %45 = alloca %struct.object*, align 8
  store %struct.Vector* %0, %struct.Vector** %7, align 8
  store %struct.Vector* %1, %struct.Vector** %8, align 8
  store %struct.Vector* %2, %struct.Vector** %9, align 8
  store %struct.Vector* %3, %struct.Vector** %10, align 8
  store %struct.Vector* %4, %struct.Vector** %11, align 8
  store %struct.Hash* %5, %struct.Hash** %12, align 8
  %46 = load %struct.Vector*, %struct.Vector** %7, align 8
  %47 = getelementptr inbounds %struct.Vector, %struct.Vector* %46, i32 0, i32 3
  %48 = load i32, i32* %47, align 4
  %49 = sext i32 %48 to i64
  store i64 %49, i64* %20, align 8
  %50 = load %struct.Vector*, %struct.Vector** %9, align 8
  %51 = call %struct.Vector* @vector_copy0(%struct.Vector* %50)
  store %struct.Vector* %51, %struct.Vector** %40, align 8
  %52 = call %struct.Vector* @vector_init(i32 200)
  store %struct.Vector* %52, %struct.Vector** %41, align 8
  %53 = load %struct.Vector*, %struct.Vector** %9, align 8
  %54 = call %struct.Vector* @tosqs(%struct.Vector* %53, i8** getelementptr inbounds ([79 x i8*], [79 x i8*]* @eval.table, i32 0, i32 0))
  store %struct.Vector* %54, %struct.Vector** %40, align 8
  %55 = call noalias i8* @GC_malloc(i64 16) #4
  %56 = bitcast i8* %55 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %56, %struct.__mpz_struct** %38, align 8
  %57 = load %struct.__mpz_struct*, %struct.__mpz_struct** %38, align 8
  call void @__gmpz_init(%struct.__mpz_struct* %57)
  br label %58

; <label>:58:                                     ; preds = %6
  %59 = load %struct.Vector*, %struct.Vector** %40, align 8
  %60 = getelementptr inbounds %struct.Vector, %struct.Vector* %59, i32 0, i32 2
  store i32 0, i32* %60, align 8
  %61 = load %struct.Vector*, %struct.Vector** %40, align 8
  %62 = call i8* @dequeue(%struct.Vector* %61)
  br label %66

; <label>:63:                                     ; preds = %66
  %64 = load %struct.Vector*, %struct.Vector** %7, align 8
  %65 = call i8* @pop(%struct.Vector* %64)
  ret i8* %65

; <label>:66:                                     ; preds = %1375, %1369, %1342, %1327, %1297, %1236, %1175, %1133, %1119, %1103, %1094, %1079, %1063, %1058, %1050, %1038, %1021, %1018, %987, %969, %956, %914, %897, %891, %888, %867, %835, %789, %736, %677, %663, %649, %635, %621, %607, %593, %575, %555, %542, %528, %510, %490, %478, %465, %456, %447, %437, %412, %383, %363, %350, %337, %325, %315, %306, %297, %284, %272, %260, %242, %222, %210, %197, %181, %147, %137, %134, %105, %97, %68, %58
  %67 = phi i8* [ %62, %58 ], [ %73, %68 ], [ %104, %97 ], [ %116, %105 ], [ %136, %134 ], [ %146, %137 ], [ %180, %147 ], [ %196, %181 ], [ %208, %197 ], [ %221, %210 ], [ %241, %222 ], [ %259, %242 ], [ %271, %260 ], [ %283, %272 ], [ %296, %284 ], [ %305, %297 ], [ %314, %306 ], [ %324, %315 ], [ %336, %325 ], [ %348, %337 ], [ %362, %350 ], [ %382, %363 ], [ %410, %383 ], [ %436, %412 ], [ %445, %437 ], [ %455, %447 ], [ %464, %456 ], [ %476, %465 ], [ %489, %478 ], [ %509, %490 ], [ %527, %510 ], [ %540, %528 ], [ %554, %542 ], [ %574, %555 ], [ %592, %575 ], [ %605, %593 ], [ %620, %607 ], [ %633, %621 ], [ %648, %635 ], [ %661, %649 ], [ %676, %663 ], [ %735, %677 ], [ %788, %736 ], [ %834, %789 ], [ %843, %835 ], [ %869, %867 ], [ %890, %888 ], [ %896, %891 ], [ %913, %897 ], [ %955, %914 ], [ %968, %956 ], [ %986, %969 ], [ %997, %987 ], [ %1020, %1018 ], [ %1037, %1021 ], [ %1049, %1038 ], [ %1057, %1050 ], [ %1062, %1058 ], [ %1078, %1063 ], [ %1093, %1079 ], [ %1102, %1094 ], [ %1118, %1103 ], [ %1132, %1119 ], [ %1174, %1133 ], [ %1235, %1175 ], [ %1296, %1236 ], [ %1326, %1297 ], [ %1341, %1327 ], [ %1368, %1342 ], [ %1374, %1369 ], [ %1390, %1375 ]
  indirectbr i8* %67, [label %63, label %68, label %74, label %209, label %677, label %835, label %844, label %891, label %897, label %147, label %634, label %117, label %181, label %349, label %411, label %736, label %870, label %1058, label %606, label %446, label %477, label %541, label %914, label %956, label %969, label %987, label %998, label %1021, label %1038, label %1050, label %242, label %383, label %510, label %272, label %1079, label %789, label %137, label %1119, label %1133, label %1175, label %1236, label %1297, label %1327, label %1342, label %1369, label %1375, label %222, label %363, label %490, label %555, label %1063, label %284, label %260, label %197, label %337, label %465, label %528, label %593, label %621, label %297, label %1103, label %437, label %456, label %210, label %350, label %478, label %542, label %607, label %635, label %412, label %447, label %306, label %315, label %325, label %1094, label %575, label %649, label %662, label %663]

; <label>:68:                                     ; preds = %66
  %69 = load %struct.Vector*, %struct.Vector** %7, align 8
  %70 = load %struct.Vector*, %struct.Vector** %40, align 8
  %71 = call i8* @dequeue(%struct.Vector* %70)
  call void @push(%struct.Vector* %69, i8* %71)
  %72 = load %struct.Vector*, %struct.Vector** %40, align 8
  %73 = call i8* @dequeue(%struct.Vector* %72)
  br label %66

; <label>:74:                                     ; preds = %66
  %75 = load %struct.Vector*, %struct.Vector** %40, align 8
  %76 = call i8* @dequeue(%struct.Vector* %75)
  %77 = bitcast i8* %76 to %struct.Vector*
  store %struct.Vector* %77, %struct.Vector** %28, align 8
  %78 = load %struct.Vector*, %struct.Vector** %28, align 8
  %79 = call i8* @vector_ref(%struct.Vector* %78, i32 0)
  %80 = ptrtoint i8* %79 to i64
  store i64 %80, i64* %16, align 8
  %81 = load %struct.Vector*, %struct.Vector** %28, align 8
  %82 = call i8* @vector_ref(%struct.Vector* %81, i32 1)
  %83 = ptrtoint i8* %82 to i64
  store i64 %83, i64* %17, align 8
  %84 = load %struct.Vector*, %struct.Vector** %8, align 8
  %85 = load %struct.Vector*, %struct.Vector** %8, align 8
  %86 = getelementptr inbounds %struct.Vector, %struct.Vector* %85, i32 0, i32 3
  %87 = load i32, i32* %86, align 4
  %88 = sext i32 %87 to i64
  %89 = load i64, i64* %16, align 8
  %90 = sub nsw i64 %88, %89
  %91 = sub nsw i64 %90, 1
  %92 = trunc i64 %91 to i32
  %93 = call i8* @vector_ref(%struct.Vector* %84, i32 %92)
  %94 = bitcast i8* %93 to %struct.Vector*
  store %struct.Vector* %94, %struct.Vector** %29, align 8
  %95 = load i64, i64* %17, align 8
  %96 = icmp sge i64 %95, 0
  br i1 %96, label %97, label %105

; <label>:97:                                     ; preds = %74
  %98 = load %struct.Vector*, %struct.Vector** %7, align 8
  %99 = load %struct.Vector*, %struct.Vector** %29, align 8
  %100 = load i64, i64* %17, align 8
  %101 = trunc i64 %100 to i32
  %102 = call i8* @vector_ref(%struct.Vector* %99, i32 %101)
  call void @push(%struct.Vector* %98, i8* %102)
  %103 = load %struct.Vector*, %struct.Vector** %40, align 8
  %104 = call i8* @dequeue(%struct.Vector* %103)
  br label %66

; <label>:105:                                    ; preds = %74
  %106 = load i64, i64* %17, align 8
  %107 = sub nsw i64 0, %106
  %108 = sub nsw i64 %107, 1
  %109 = trunc i64 %108 to i32
  %110 = load %struct.Vector*, %struct.Vector** %29, align 8
  %111 = getelementptr inbounds %struct.Vector, %struct.Vector* %110, i32 0, i32 2
  store i32 %109, i32* %111, align 8
  %112 = load %struct.Vector*, %struct.Vector** %7, align 8
  %113 = load %struct.Vector*, %struct.Vector** %29, align 8
  %114 = bitcast %struct.Vector* %113 to i8*
  call void @push(%struct.Vector* %112, i8* %114)
  %115 = load %struct.Vector*, %struct.Vector** %40, align 8
  %116 = call i8* @dequeue(%struct.Vector* %115)
  br label %66

; <label>:117:                                    ; preds = %66
  %118 = load %struct.Vector*, %struct.Vector** %40, align 8
  %119 = call i8* @dequeue(%struct.Vector* %118)
  %120 = bitcast i8* %119 to %struct.Symbol*
  store %struct.Symbol* %120, %struct.Symbol** %13, align 8
  %121 = load %struct.Hash*, %struct.Hash** %12, align 8
  %122 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %123 = call i8** @Hash_get(%struct.Hash* %121, %struct.Symbol* %122)
  store i8** %123, i8*** %31, align 8
  %124 = icmp eq i8** %123, null
  br i1 %124, label %125, label %130

; <label>:125:                                    ; preds = %117
  %126 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %127 = getelementptr inbounds %struct.Symbol, %struct.Symbol* %126, i32 0, i32 1
  %128 = load i8*, i8** %127, align 8
  %129 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i32 0, i32 0), i8* %128)
  br label %134

; <label>:130:                                    ; preds = %117
  %131 = load %struct.Vector*, %struct.Vector** %7, align 8
  %132 = load i8**, i8*** %31, align 8
  %133 = load i8*, i8** %132, align 8
  call void @push(%struct.Vector* %131, i8* %133)
  br label %134

; <label>:134:                                    ; preds = %130, %125
  %135 = load %struct.Vector*, %struct.Vector** %40, align 8
  %136 = call i8* @dequeue(%struct.Vector* %135)
  br label %66

; <label>:137:                                    ; preds = %66
  %138 = load %struct.Vector*, %struct.Vector** %7, align 8
  %139 = call i8* @pop(%struct.Vector* %138)
  %140 = bitcast i8* %139 to i64*
  %141 = load i64, i64* %140, align 8
  store i64 %141, i64* %16, align 8
  %142 = load %struct.Vector*, %struct.Vector** %7, align 8
  %143 = load i64, i64* %16, align 8
  %144 = inttoptr i64 %143 to i8*
  call void @push(%struct.Vector* %142, i8* %144)
  %145 = load %struct.Vector*, %struct.Vector** %40, align 8
  %146 = call i8* @dequeue(%struct.Vector* %145)
  br label %66

; <label>:147:                                    ; preds = %66
  %148 = load %struct.Vector*, %struct.Vector** %7, align 8
  %149 = load %struct.Vector*, %struct.Vector** %7, align 8
  %150 = getelementptr inbounds %struct.Vector, %struct.Vector* %149, i32 0, i32 3
  %151 = load i32, i32* %150, align 4
  %152 = sub nsw i32 %151, 1
  %153 = call i8* @vector_ref(%struct.Vector* %148, i32 %152)
  store i8* %153, i8** %32, align 8
  %154 = load %struct.Vector*, %struct.Vector** %40, align 8
  %155 = call i8* @dequeue(%struct.Vector* %154)
  %156 = bitcast i8* %155 to %struct.Vector*
  store %struct.Vector* %156, %struct.Vector** %28, align 8
  %157 = load %struct.Vector*, %struct.Vector** %28, align 8
  %158 = call i8* @vector_ref(%struct.Vector* %157, i32 0)
  %159 = ptrtoint i8* %158 to i64
  store i64 %159, i64* %16, align 8
  %160 = load %struct.Vector*, %struct.Vector** %28, align 8
  %161 = call i8* @vector_ref(%struct.Vector* %160, i32 1)
  %162 = ptrtoint i8* %161 to i64
  store i64 %162, i64* %17, align 8
  %163 = load %struct.Vector*, %struct.Vector** %8, align 8
  %164 = load %struct.Vector*, %struct.Vector** %8, align 8
  %165 = getelementptr inbounds %struct.Vector, %struct.Vector* %164, i32 0, i32 3
  %166 = load i32, i32* %165, align 4
  %167 = sext i32 %166 to i64
  %168 = load i64, i64* %16, align 8
  %169 = sub nsw i64 %167, %168
  %170 = sub nsw i64 %169, 1
  %171 = trunc i64 %170 to i32
  %172 = call i8* @vector_ref(%struct.Vector* %163, i32 %171)
  %173 = bitcast i8* %172 to %struct.Vector*
  store %struct.Vector* %173, %struct.Vector** %29, align 8
  %174 = load %struct.Vector*, %struct.Vector** %29, align 8
  %175 = load i64, i64* %17, align 8
  %176 = trunc i64 %175 to i32
  %177 = load i8*, i8** %32, align 8
  %178 = bitcast i8* %177 to i8**
  call void @vector_set(%struct.Vector* %174, i32 %176, i8** %178)
  %179 = load %struct.Vector*, %struct.Vector** %40, align 8
  %180 = call i8* @dequeue(%struct.Vector* %179)
  br label %66

; <label>:181:                                    ; preds = %66
  %182 = load %struct.Vector*, %struct.Vector** %7, align 8
  %183 = load %struct.Vector*, %struct.Vector** %7, align 8
  %184 = getelementptr inbounds %struct.Vector, %struct.Vector* %183, i32 0, i32 3
  %185 = load i32, i32* %184, align 4
  %186 = sub nsw i32 %185, 1
  %187 = call i8* @vector_ref(%struct.Vector* %182, i32 %186)
  store i8* %187, i8** %32, align 8
  %188 = load %struct.Vector*, %struct.Vector** %40, align 8
  %189 = call i8* @dequeue(%struct.Vector* %188)
  %190 = bitcast i8* %189 to %struct.Symbol*
  store %struct.Symbol* %190, %struct.Symbol** %13, align 8
  %191 = load %struct.Hash*, %struct.Hash** %12, align 8
  %192 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %193 = load i8*, i8** %32, align 8
  %194 = call i64 @Hash_put(%struct.Hash* %191, %struct.Symbol* %192, i8* %193)
  %195 = load %struct.Vector*, %struct.Vector** %40, align 8
  %196 = call i8* @dequeue(%struct.Vector* %195)
  br label %66

; <label>:197:                                    ; preds = %66
  %198 = load %struct.Vector*, %struct.Vector** %7, align 8
  %199 = load %struct.Vector*, %struct.Vector** %7, align 8
  %200 = call i8* @pop(%struct.Vector* %199)
  %201 = bitcast i8* %200 to %struct.object*
  %202 = load %struct.Vector*, %struct.Vector** %7, align 8
  %203 = call i8* @pop(%struct.Vector* %202)
  %204 = bitcast i8* %203 to %struct.object*
  %205 = call %struct.object* @objadd(%struct.object* %201, %struct.object* %204)
  %206 = bitcast %struct.object* %205 to i8*
  call void @push(%struct.Vector* %198, i8* %206)
  %207 = load %struct.Vector*, %struct.Vector** %40, align 8
  %208 = call i8* @dequeue(%struct.Vector* %207)
  br label %66

; <label>:209:                                    ; preds = %66
  br label %210

; <label>:210:                                    ; preds = %209, %66
  %211 = load %struct.Vector*, %struct.Vector** %7, align 8
  %212 = load %struct.Vector*, %struct.Vector** %7, align 8
  %213 = call i8* @pop(%struct.Vector* %212)
  %214 = ptrtoint i8* %213 to i64
  %215 = load %struct.Vector*, %struct.Vector** %7, align 8
  %216 = call i8* @pop(%struct.Vector* %215)
  %217 = ptrtoint i8* %216 to i64
  %218 = add nsw i64 %214, %217
  %219 = inttoptr i64 %218 to i8*
  call void @push(%struct.Vector* %211, i8* %219)
  %220 = load %struct.Vector*, %struct.Vector** %40, align 8
  %221 = call i8* @dequeue(%struct.Vector* %220)
  br label %66

; <label>:222:                                    ; preds = %66
  %223 = load %struct.Vector*, %struct.Vector** %7, align 8
  %224 = call i8* @pop(%struct.Vector* %223)
  %225 = bitcast i8* %224 to double*
  store double* %225, double** %42, align 8
  %226 = load %struct.Vector*, %struct.Vector** %7, align 8
  %227 = call i8* @pop(%struct.Vector* %226)
  %228 = bitcast i8* %227 to double*
  store double* %228, double** %43, align 8
  %229 = call noalias i8* @GC_malloc(i64 8) #4
  %230 = bitcast i8* %229 to double*
  store double* %230, double** %44, align 8
  %231 = load double*, double** %42, align 8
  %232 = load double, double* %231, align 8
  %233 = load double*, double** %43, align 8
  %234 = load double, double* %233, align 8
  %235 = fadd double %232, %234
  %236 = load double*, double** %44, align 8
  store double %235, double* %236, align 8
  %237 = load %struct.Vector*, %struct.Vector** %7, align 8
  %238 = load double*, double** %44, align 8
  %239 = bitcast double* %238 to i8*
  call void @push(%struct.Vector* %237, i8* %239)
  %240 = load %struct.Vector*, %struct.Vector** %40, align 8
  %241 = call i8* @dequeue(%struct.Vector* %240)
  br label %66

; <label>:242:                                    ; preds = %66
  %243 = load %struct.Vector*, %struct.Vector** %7, align 8
  %244 = call i8* @pop(%struct.Vector* %243)
  %245 = bitcast i8* %244 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %245, %struct.__mpz_struct** %36, align 8
  %246 = load %struct.Vector*, %struct.Vector** %7, align 8
  %247 = call i8* @pop(%struct.Vector* %246)
  %248 = bitcast i8* %247 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %248, %struct.__mpz_struct** %35, align 8
  %249 = call noalias i8* @GC_malloc(i64 16) #4
  %250 = bitcast i8* %249 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %250, %struct.__mpz_struct** %37, align 8
  %251 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  call void @__gmpz_init(%struct.__mpz_struct* %251)
  %252 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %253 = load %struct.__mpz_struct*, %struct.__mpz_struct** %35, align 8
  %254 = load %struct.__mpz_struct*, %struct.__mpz_struct** %36, align 8
  call void @__gmpz_add(%struct.__mpz_struct* %252, %struct.__mpz_struct* %253, %struct.__mpz_struct* %254)
  %255 = load %struct.Vector*, %struct.Vector** %7, align 8
  %256 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %257 = bitcast %struct.__mpz_struct* %256 to i8*
  call void @push(%struct.Vector* %255, i8* %257)
  %258 = load %struct.Vector*, %struct.Vector** %40, align 8
  %259 = call i8* @dequeue(%struct.Vector* %258)
  br label %66

; <label>:260:                                    ; preds = %66
  %261 = call noalias i8* @GC_malloc(i64 16) #4
  %262 = bitcast i8* %261 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %262, %struct.__mpz_struct** %37, align 8
  %263 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %264 = load %struct.Vector*, %struct.Vector** %7, align 8
  %265 = call i8* @pop(%struct.Vector* %264)
  %266 = bitcast i8* %265 to %struct.__mpz_struct*
  call void @__gmpz_init_set(%struct.__mpz_struct* %263, %struct.__mpz_struct* %266)
  %267 = load %struct.Vector*, %struct.Vector** %7, align 8
  %268 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %269 = bitcast %struct.__mpz_struct* %268 to i8*
  call void @push(%struct.Vector* %267, i8* %269)
  %270 = load %struct.Vector*, %struct.Vector** %40, align 8
  %271 = call i8* @dequeue(%struct.Vector* %270)
  br label %66

; <label>:272:                                    ; preds = %66
  %273 = call noalias i8* @GC_malloc(i64 16) #4
  %274 = bitcast i8* %273 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %274, %struct.__mpz_struct** %37, align 8
  %275 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %276 = load %struct.Vector*, %struct.Vector** %7, align 8
  %277 = call i8* @pop(%struct.Vector* %276)
  %278 = ptrtoint i8* %277 to i64
  call void @__gmpz_init_set_si(%struct.__mpz_struct* %275, i64 %278)
  %279 = load %struct.Vector*, %struct.Vector** %7, align 8
  %280 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %281 = bitcast %struct.__mpz_struct* %280 to i8*
  call void @push(%struct.Vector* %279, i8* %281)
  %282 = load %struct.Vector*, %struct.Vector** %40, align 8
  %283 = call i8* @dequeue(%struct.Vector* %282)
  br label %66

; <label>:284:                                    ; preds = %66
  %285 = call noalias i8* @GC_malloc(i64 8) #4
  %286 = bitcast i8* %285 to double*
  store double* %286, double** %44, align 8
  %287 = load %struct.Vector*, %struct.Vector** %7, align 8
  %288 = call i8* @pop(%struct.Vector* %287)
  %289 = ptrtoint i8* %288 to i64
  %290 = sitofp i64 %289 to double
  %291 = load double*, double** %44, align 8
  store double %290, double* %291, align 8
  %292 = load %struct.Vector*, %struct.Vector** %7, align 8
  %293 = load double*, double** %44, align 8
  %294 = bitcast double* %293 to i8*
  call void @push(%struct.Vector* %292, i8* %294)
  %295 = load %struct.Vector*, %struct.Vector** %40, align 8
  %296 = call i8* @dequeue(%struct.Vector* %295)
  br label %66

; <label>:297:                                    ; preds = %66
  %298 = load %struct.Vector*, %struct.Vector** %7, align 8
  %299 = load %struct.Vector*, %struct.Vector** %7, align 8
  %300 = call i8* @pop(%struct.Vector* %299)
  %301 = ptrtoint i8* %300 to i64
  %302 = call %struct.object* @newINT(i64 %301)
  %303 = bitcast %struct.object* %302 to i8*
  call void @push(%struct.Vector* %298, i8* %303)
  %304 = load %struct.Vector*, %struct.Vector** %40, align 8
  %305 = call i8* @dequeue(%struct.Vector* %304)
  br label %66

; <label>:306:                                    ; preds = %66
  %307 = load %struct.Vector*, %struct.Vector** %7, align 8
  %308 = load %struct.Vector*, %struct.Vector** %7, align 8
  %309 = call i8* @pop(%struct.Vector* %308)
  %310 = bitcast i8* %309 to %struct.__mpz_struct*
  %311 = call %struct.object* @newLINT(%struct.__mpz_struct* %310)
  %312 = bitcast %struct.object* %311 to i8*
  call void @push(%struct.Vector* %307, i8* %312)
  %313 = load %struct.Vector*, %struct.Vector** %40, align 8
  %314 = call i8* @dequeue(%struct.Vector* %313)
  br label %66

; <label>:315:                                    ; preds = %66
  %316 = load %struct.Vector*, %struct.Vector** %7, align 8
  %317 = load %struct.Vector*, %struct.Vector** %7, align 8
  %318 = call i8* @pop(%struct.Vector* %317)
  %319 = bitcast i8* %318 to double*
  %320 = load double, double* %319, align 8
  %321 = call %struct.object* @newFLT(double %320)
  %322 = bitcast %struct.object* %321 to i8*
  call void @push(%struct.Vector* %316, i8* %322)
  %323 = load %struct.Vector*, %struct.Vector** %40, align 8
  %324 = call i8* @dequeue(%struct.Vector* %323)
  br label %66

; <label>:325:                                    ; preds = %66
  %326 = load %struct.Vector*, %struct.Vector** %7, align 8
  %327 = load %struct.Vector*, %struct.Vector** %7, align 8
  %328 = call i8* @pop(%struct.Vector* %327)
  %329 = ptrtoint i8* %328 to i64
  %330 = load %struct.Vector*, %struct.Vector** %7, align 8
  %331 = call i8* @pop(%struct.Vector* %330)
  %332 = ptrtoint i8* %331 to i64
  %333 = call %struct.object* @newRAT_i(i64 %329, i64 %332)
  %334 = bitcast %struct.object* %333 to i8*
  call void @push(%struct.Vector* %326, i8* %334)
  %335 = load %struct.Vector*, %struct.Vector** %40, align 8
  %336 = call i8* @dequeue(%struct.Vector* %335)
  br label %66

; <label>:337:                                    ; preds = %66
  %338 = load %struct.Vector*, %struct.Vector** %7, align 8
  %339 = load %struct.Vector*, %struct.Vector** %7, align 8
  %340 = call i8* @pop(%struct.Vector* %339)
  %341 = bitcast i8* %340 to %struct.object*
  %342 = load %struct.Vector*, %struct.Vector** %7, align 8
  %343 = call i8* @pop(%struct.Vector* %342)
  %344 = bitcast i8* %343 to %struct.object*
  %345 = call %struct.object* @objsub(%struct.object* %341, %struct.object* %344)
  %346 = bitcast %struct.object* %345 to i8*
  call void @push(%struct.Vector* %338, i8* %346)
  %347 = load %struct.Vector*, %struct.Vector** %40, align 8
  %348 = call i8* @dequeue(%struct.Vector* %347)
  br label %66

; <label>:349:                                    ; preds = %66
  br label %350

; <label>:350:                                    ; preds = %349, %66
  %351 = load %struct.Vector*, %struct.Vector** %7, align 8
  %352 = call i8* @pop(%struct.Vector* %351)
  %353 = ptrtoint i8* %352 to i64
  store i64 %353, i64* %16, align 8
  %354 = load %struct.Vector*, %struct.Vector** %7, align 8
  %355 = load %struct.Vector*, %struct.Vector** %7, align 8
  %356 = call i8* @pop(%struct.Vector* %355)
  %357 = ptrtoint i8* %356 to i64
  %358 = load i64, i64* %16, align 8
  %359 = sub nsw i64 %357, %358
  %360 = inttoptr i64 %359 to i8*
  call void @push(%struct.Vector* %354, i8* %360)
  %361 = load %struct.Vector*, %struct.Vector** %40, align 8
  %362 = call i8* @dequeue(%struct.Vector* %361)
  br label %66

; <label>:363:                                    ; preds = %66
  %364 = load %struct.Vector*, %struct.Vector** %7, align 8
  %365 = call i8* @pop(%struct.Vector* %364)
  %366 = bitcast i8* %365 to double*
  store double* %366, double** %42, align 8
  %367 = load %struct.Vector*, %struct.Vector** %7, align 8
  %368 = call i8* @pop(%struct.Vector* %367)
  %369 = bitcast i8* %368 to double*
  store double* %369, double** %43, align 8
  %370 = call noalias i8* @GC_malloc(i64 8) #4
  %371 = bitcast i8* %370 to double*
  store double* %371, double** %44, align 8
  %372 = load double*, double** %42, align 8
  %373 = load double, double* %372, align 8
  %374 = load double*, double** %43, align 8
  %375 = load double, double* %374, align 8
  %376 = fsub double %373, %375
  %377 = load double*, double** %44, align 8
  store double %376, double* %377, align 8
  %378 = load %struct.Vector*, %struct.Vector** %7, align 8
  %379 = load double*, double** %44, align 8
  %380 = bitcast double* %379 to i8*
  call void @push(%struct.Vector* %378, i8* %380)
  %381 = load %struct.Vector*, %struct.Vector** %40, align 8
  %382 = call i8* @dequeue(%struct.Vector* %381)
  br label %66

; <label>:383:                                    ; preds = %66
  %384 = load %struct.Vector*, %struct.Vector** %7, align 8
  %385 = getelementptr inbounds %struct.Vector, %struct.Vector* %384, i32 0, i32 1
  %386 = load i8**, i8*** %385, align 8
  %387 = load %struct.Vector*, %struct.Vector** %7, align 8
  %388 = getelementptr inbounds %struct.Vector, %struct.Vector* %387, i32 0, i32 3
  %389 = load i32, i32* %388, align 4
  %390 = add nsw i32 %389, -1
  store i32 %390, i32* %388, align 4
  %391 = sext i32 %390 to i64
  %392 = getelementptr inbounds i8*, i8** %386, i64 %391
  %393 = load i8*, i8** %392, align 8
  %394 = bitcast i8* %393 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %394, %struct.__mpz_struct** %36, align 8
  %395 = load %struct.Vector*, %struct.Vector** %7, align 8
  %396 = getelementptr inbounds %struct.Vector, %struct.Vector* %395, i32 0, i32 1
  %397 = load i8**, i8*** %396, align 8
  %398 = load %struct.Vector*, %struct.Vector** %7, align 8
  %399 = getelementptr inbounds %struct.Vector, %struct.Vector* %398, i32 0, i32 3
  %400 = load i32, i32* %399, align 4
  %401 = sub nsw i32 %400, 1
  %402 = sext i32 %401 to i64
  %403 = getelementptr inbounds i8*, i8** %397, i64 %402
  %404 = load i8*, i8** %403, align 8
  %405 = bitcast i8* %404 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %405, %struct.__mpz_struct** %35, align 8
  %406 = load %struct.__mpz_struct*, %struct.__mpz_struct** %35, align 8
  %407 = load %struct.__mpz_struct*, %struct.__mpz_struct** %35, align 8
  %408 = load %struct.__mpz_struct*, %struct.__mpz_struct** %36, align 8
  call void @__gmpz_sub(%struct.__mpz_struct* %406, %struct.__mpz_struct* %407, %struct.__mpz_struct* %408)
  %409 = load %struct.Vector*, %struct.Vector** %40, align 8
  %410 = call i8* @dequeue(%struct.Vector* %409)
  br label %66

; <label>:411:                                    ; preds = %66
  br label %412

; <label>:412:                                    ; preds = %411, %66
  %413 = load %struct.Vector*, %struct.Vector** %7, align 8
  %414 = getelementptr inbounds %struct.Vector, %struct.Vector* %413, i32 0, i32 1
  %415 = load i8**, i8*** %414, align 8
  %416 = load %struct.Vector*, %struct.Vector** %7, align 8
  %417 = getelementptr inbounds %struct.Vector, %struct.Vector* %416, i32 0, i32 3
  %418 = load i32, i32* %417, align 4
  %419 = sub nsw i32 %418, 1
  %420 = sext i32 %419 to i64
  %421 = getelementptr inbounds i8*, i8** %415, i64 %420
  %422 = load i8*, i8** %421, align 8
  %423 = ptrtoint i8* %422 to i64
  %424 = sub nsw i64 %423, 1
  %425 = inttoptr i64 %424 to i8*
  %426 = load %struct.Vector*, %struct.Vector** %7, align 8
  %427 = getelementptr inbounds %struct.Vector, %struct.Vector* %426, i32 0, i32 1
  %428 = load i8**, i8*** %427, align 8
  %429 = load %struct.Vector*, %struct.Vector** %7, align 8
  %430 = getelementptr inbounds %struct.Vector, %struct.Vector* %429, i32 0, i32 3
  %431 = load i32, i32* %430, align 4
  %432 = sub nsw i32 %431, 1
  %433 = sext i32 %432 to i64
  %434 = getelementptr inbounds i8*, i8** %428, i64 %433
  store i8* %425, i8** %434, align 8
  %435 = load %struct.Vector*, %struct.Vector** %40, align 8
  %436 = call i8* @dequeue(%struct.Vector* %435)
  br label %66

; <label>:437:                                    ; preds = %66
  %438 = load %struct.Vector*, %struct.Vector** %7, align 8
  %439 = load %struct.Vector*, %struct.Vector** %7, align 8
  %440 = call i8* @pop(%struct.Vector* %439)
  %441 = bitcast i8* %440 to %struct.object*
  %442 = call %struct.object* @objdec(%struct.object* %441)
  %443 = bitcast %struct.object* %442 to i8*
  call void @push(%struct.Vector* %438, i8* %443)
  %444 = load %struct.Vector*, %struct.Vector** %40, align 8
  %445 = call i8* @dequeue(%struct.Vector* %444)
  br label %66

; <label>:446:                                    ; preds = %66
  br label %447

; <label>:447:                                    ; preds = %446, %66
  %448 = load %struct.Vector*, %struct.Vector** %7, align 8
  %449 = load %struct.Vector*, %struct.Vector** %7, align 8
  %450 = call i8* @pop(%struct.Vector* %449)
  %451 = ptrtoint i8* %450 to i64
  %452 = add nsw i64 %451, 1
  %453 = inttoptr i64 %452 to i8*
  call void @push(%struct.Vector* %448, i8* %453)
  %454 = load %struct.Vector*, %struct.Vector** %40, align 8
  %455 = call i8* @dequeue(%struct.Vector* %454)
  br label %66

; <label>:456:                                    ; preds = %66
  %457 = load %struct.Vector*, %struct.Vector** %7, align 8
  %458 = load %struct.Vector*, %struct.Vector** %7, align 8
  %459 = call i8* @pop(%struct.Vector* %458)
  %460 = bitcast i8* %459 to %struct.object*
  %461 = call %struct.object* @objinc(%struct.object* %460)
  %462 = bitcast %struct.object* %461 to i8*
  call void @push(%struct.Vector* %457, i8* %462)
  %463 = load %struct.Vector*, %struct.Vector** %40, align 8
  %464 = call i8* @dequeue(%struct.Vector* %463)
  br label %66

; <label>:465:                                    ; preds = %66
  %466 = load %struct.Vector*, %struct.Vector** %7, align 8
  %467 = load %struct.Vector*, %struct.Vector** %7, align 8
  %468 = call i8* @pop(%struct.Vector* %467)
  %469 = bitcast i8* %468 to %struct.object*
  %470 = load %struct.Vector*, %struct.Vector** %7, align 8
  %471 = call i8* @pop(%struct.Vector* %470)
  %472 = bitcast i8* %471 to %struct.object*
  %473 = call %struct.object* @objmul(%struct.object* %469, %struct.object* %472)
  %474 = bitcast %struct.object* %473 to i8*
  call void @push(%struct.Vector* %466, i8* %474)
  %475 = load %struct.Vector*, %struct.Vector** %40, align 8
  %476 = call i8* @dequeue(%struct.Vector* %475)
  br label %66

; <label>:477:                                    ; preds = %66
  br label %478

; <label>:478:                                    ; preds = %477, %66
  %479 = load %struct.Vector*, %struct.Vector** %7, align 8
  %480 = load %struct.Vector*, %struct.Vector** %7, align 8
  %481 = call i8* @pop(%struct.Vector* %480)
  %482 = ptrtoint i8* %481 to i64
  %483 = load %struct.Vector*, %struct.Vector** %7, align 8
  %484 = call i8* @pop(%struct.Vector* %483)
  %485 = ptrtoint i8* %484 to i64
  %486 = mul nsw i64 %482, %485
  %487 = inttoptr i64 %486 to i8*
  call void @push(%struct.Vector* %479, i8* %487)
  %488 = load %struct.Vector*, %struct.Vector** %40, align 8
  %489 = call i8* @dequeue(%struct.Vector* %488)
  br label %66

; <label>:490:                                    ; preds = %66
  %491 = load %struct.Vector*, %struct.Vector** %7, align 8
  %492 = call i8* @pop(%struct.Vector* %491)
  %493 = bitcast i8* %492 to double*
  store double* %493, double** %42, align 8
  %494 = load %struct.Vector*, %struct.Vector** %7, align 8
  %495 = call i8* @pop(%struct.Vector* %494)
  %496 = bitcast i8* %495 to double*
  store double* %496, double** %43, align 8
  %497 = call noalias i8* @GC_malloc(i64 8) #4
  %498 = bitcast i8* %497 to double*
  store double* %498, double** %44, align 8
  %499 = load double*, double** %42, align 8
  %500 = load double, double* %499, align 8
  %501 = load double*, double** %43, align 8
  %502 = load double, double* %501, align 8
  %503 = fmul double %500, %502
  %504 = load double*, double** %44, align 8
  store double %503, double* %504, align 8
  %505 = load %struct.Vector*, %struct.Vector** %7, align 8
  %506 = load double*, double** %44, align 8
  %507 = bitcast double* %506 to i8*
  call void @push(%struct.Vector* %505, i8* %507)
  %508 = load %struct.Vector*, %struct.Vector** %40, align 8
  %509 = call i8* @dequeue(%struct.Vector* %508)
  br label %66

; <label>:510:                                    ; preds = %66
  %511 = load %struct.Vector*, %struct.Vector** %7, align 8
  %512 = call i8* @pop(%struct.Vector* %511)
  %513 = bitcast i8* %512 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %513, %struct.__mpz_struct** %36, align 8
  %514 = load %struct.Vector*, %struct.Vector** %7, align 8
  %515 = call i8* @pop(%struct.Vector* %514)
  %516 = bitcast i8* %515 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %516, %struct.__mpz_struct** %35, align 8
  %517 = call noalias i8* @GC_malloc(i64 16) #4
  %518 = bitcast i8* %517 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %518, %struct.__mpz_struct** %37, align 8
  %519 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  call void @__gmpz_init(%struct.__mpz_struct* %519)
  %520 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %521 = load %struct.__mpz_struct*, %struct.__mpz_struct** %35, align 8
  %522 = load %struct.__mpz_struct*, %struct.__mpz_struct** %36, align 8
  call void @__gmpz_mul(%struct.__mpz_struct* %520, %struct.__mpz_struct* %521, %struct.__mpz_struct* %522)
  %523 = load %struct.Vector*, %struct.Vector** %7, align 8
  %524 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %525 = bitcast %struct.__mpz_struct* %524 to i8*
  call void @push(%struct.Vector* %523, i8* %525)
  %526 = load %struct.Vector*, %struct.Vector** %40, align 8
  %527 = call i8* @dequeue(%struct.Vector* %526)
  br label %66

; <label>:528:                                    ; preds = %66
  %529 = load %struct.Vector*, %struct.Vector** %7, align 8
  %530 = call i8* @pop(%struct.Vector* %529)
  %531 = bitcast i8* %530 to %struct.object*
  store %struct.object* %531, %struct.object** %45, align 8
  %532 = load %struct.Vector*, %struct.Vector** %7, align 8
  %533 = load %struct.Vector*, %struct.Vector** %7, align 8
  %534 = call i8* @pop(%struct.Vector* %533)
  %535 = bitcast i8* %534 to %struct.object*
  %536 = load %struct.object*, %struct.object** %45, align 8
  %537 = call %struct.object* @objdiv(%struct.object* %535, %struct.object* %536)
  %538 = bitcast %struct.object* %537 to i8*
  call void @push(%struct.Vector* %532, i8* %538)
  %539 = load %struct.Vector*, %struct.Vector** %40, align 8
  %540 = call i8* @dequeue(%struct.Vector* %539)
  br label %66

; <label>:541:                                    ; preds = %66
  br label %542

; <label>:542:                                    ; preds = %541, %66
  %543 = load %struct.Vector*, %struct.Vector** %7, align 8
  %544 = call i8* @pop(%struct.Vector* %543)
  %545 = ptrtoint i8* %544 to i64
  store i64 %545, i64* %19, align 8
  %546 = load %struct.Vector*, %struct.Vector** %7, align 8
  %547 = load %struct.Vector*, %struct.Vector** %7, align 8
  %548 = call i8* @pop(%struct.Vector* %547)
  %549 = ptrtoint i8* %548 to i64
  %550 = load i64, i64* %19, align 8
  %551 = sdiv i64 %549, %550
  %552 = inttoptr i64 %551 to i8*
  call void @push(%struct.Vector* %546, i8* %552)
  %553 = load %struct.Vector*, %struct.Vector** %40, align 8
  %554 = call i8* @dequeue(%struct.Vector* %553)
  br label %66

; <label>:555:                                    ; preds = %66
  %556 = load %struct.Vector*, %struct.Vector** %7, align 8
  %557 = call i8* @pop(%struct.Vector* %556)
  %558 = bitcast i8* %557 to double*
  store double* %558, double** %42, align 8
  %559 = load %struct.Vector*, %struct.Vector** %7, align 8
  %560 = call i8* @pop(%struct.Vector* %559)
  %561 = bitcast i8* %560 to double*
  store double* %561, double** %43, align 8
  %562 = call noalias i8* @GC_malloc(i64 8) #4
  %563 = bitcast i8* %562 to double*
  store double* %563, double** %44, align 8
  %564 = load double*, double** %42, align 8
  %565 = load double, double* %564, align 8
  %566 = load double*, double** %43, align 8
  %567 = load double, double* %566, align 8
  %568 = fdiv double %565, %567
  %569 = load double*, double** %44, align 8
  store double %568, double* %569, align 8
  %570 = load %struct.Vector*, %struct.Vector** %7, align 8
  %571 = load double*, double** %44, align 8
  %572 = bitcast double* %571 to i8*
  call void @push(%struct.Vector* %570, i8* %572)
  %573 = load %struct.Vector*, %struct.Vector** %40, align 8
  %574 = call i8* @dequeue(%struct.Vector* %573)
  br label %66

; <label>:575:                                    ; preds = %66
  %576 = load %struct.Vector*, %struct.Vector** %7, align 8
  %577 = call i8* @pop(%struct.Vector* %576)
  %578 = bitcast i8* %577 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %578, %struct.__mpz_struct** %36, align 8
  %579 = load %struct.Vector*, %struct.Vector** %7, align 8
  %580 = call i8* @pop(%struct.Vector* %579)
  %581 = bitcast i8* %580 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %581, %struct.__mpz_struct** %35, align 8
  %582 = call noalias i8* @GC_malloc(i64 16) #4
  %583 = bitcast i8* %582 to %struct.__mpz_struct*
  store %struct.__mpz_struct* %583, %struct.__mpz_struct** %37, align 8
  %584 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  call void @__gmpz_init(%struct.__mpz_struct* %584)
  %585 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %586 = load %struct.__mpz_struct*, %struct.__mpz_struct** %35, align 8
  %587 = load %struct.__mpz_struct*, %struct.__mpz_struct** %36, align 8
  call void @__gmpz_fdiv_q(%struct.__mpz_struct* %585, %struct.__mpz_struct* %586, %struct.__mpz_struct* %587)
  %588 = load %struct.Vector*, %struct.Vector** %7, align 8
  %589 = load %struct.__mpz_struct*, %struct.__mpz_struct** %37, align 8
  %590 = bitcast %struct.__mpz_struct* %589 to i8*
  call void @push(%struct.Vector* %588, i8* %590)
  %591 = load %struct.Vector*, %struct.Vector** %40, align 8
  %592 = call i8* @dequeue(%struct.Vector* %591)
  br label %66

; <label>:593:                                    ; preds = %66
  %594 = load %struct.Vector*, %struct.Vector** %7, align 8
  %595 = load %struct.Vector*, %struct.Vector** %7, align 8
  %596 = call i8* @pop(%struct.Vector* %595)
  %597 = bitcast i8* %596 to %struct.object*
  %598 = load %struct.Vector*, %struct.Vector** %7, align 8
  %599 = call i8* @pop(%struct.Vector* %598)
  %600 = bitcast i8* %599 to %struct.object*
  %601 = call i32 @objeq(%struct.object* %597, %struct.object* %600)
  %602 = sext i32 %601 to i64
  %603 = inttoptr i64 %602 to i8*
  call void @push(%struct.Vector* %594, i8* %603)
  %604 = load %struct.Vector*, %struct.Vector** %40, align 8
  %605 = call i8* @dequeue(%struct.Vector* %604)
  br label %66

; <label>:606:                                    ; preds = %66
  br label %607

; <label>:607:                                    ; preds = %606, %66
  %608 = load %struct.Vector*, %struct.Vector** %7, align 8
  %609 = load %struct.Vector*, %struct.Vector** %7, align 8
  %610 = call i8* @pop(%struct.Vector* %609)
  %611 = ptrtoint i8* %610 to i64
  %612 = load %struct.Vector*, %struct.Vector** %7, align 8
  %613 = call i8* @pop(%struct.Vector* %612)
  %614 = ptrtoint i8* %613 to i64
  %615 = icmp eq i64 %611, %614
  %616 = zext i1 %615 to i32
  %617 = sext i32 %616 to i64
  %618 = inttoptr i64 %617 to i8*
  call void @push(%struct.Vector* %608, i8* %618)
  %619 = load %struct.Vector*, %struct.Vector** %40, align 8
  %620 = call i8* @dequeue(%struct.Vector* %619)
  br label %66

; <label>:621:                                    ; preds = %66
  %622 = load %struct.Vector*, %struct.Vector** %7, align 8
  %623 = load %struct.Vector*, %struct.Vector** %7, align 8
  %624 = call i8* @pop(%struct.Vector* %623)
  %625 = bitcast i8* %624 to %struct.object*
  %626 = load %struct.Vector*, %struct.Vector** %7, align 8
  %627 = call i8* @pop(%struct.Vector* %626)
  %628 = bitcast i8* %627 to %struct.object*
  %629 = call i32 @objle(%struct.object* %625, %struct.object* %628)
  %630 = sext i32 %629 to i64
  %631 = inttoptr i64 %630 to i8*
  call void @push(%struct.Vector* %622, i8* %631)
  %632 = load %struct.Vector*, %struct.Vector** %40, align 8
  %633 = call i8* @dequeue(%struct.Vector* %632)
  br label %66

; <label>:634:                                    ; preds = %66
  br label %635

; <label>:635:                                    ; preds = %634, %66
  %636 = load %struct.Vector*, %struct.Vector** %7, align 8
  %637 = load %struct.Vector*, %struct.Vector** %7, align 8
  %638 = call i8* @pop(%struct.Vector* %637)
  %639 = ptrtoint i8* %638 to i64
  %640 = load %struct.Vector*, %struct.Vector** %7, align 8
  %641 = call i8* @pop(%struct.Vector* %640)
  %642 = ptrtoint i8* %641 to i64
  %643 = icmp sge i64 %639, %642
  %644 = zext i1 %643 to i32
  %645 = sext i32 %644 to i64
  %646 = inttoptr i64 %645 to i8*
  call void @push(%struct.Vector* %636, i8* %646)
  %647 = load %struct.Vector*, %struct.Vector** %40, align 8
  %648 = call i8* @dequeue(%struct.Vector* %647)
  br label %66

; <label>:649:                                    ; preds = %66
  %650 = load %struct.Vector*, %struct.Vector** %7, align 8
  %651 = load %struct.Vector*, %struct.Vector** %7, align 8
  %652 = call i8* @pop(%struct.Vector* %651)
  %653 = bitcast i8* %652 to %struct.object*
  %654 = load %struct.Vector*, %struct.Vector** %7, align 8
  %655 = call i8* @pop(%struct.Vector* %654)
  %656 = bitcast i8* %655 to %struct.object*
  %657 = call i32 @objlt(%struct.object* %653, %struct.object* %656)
  %658 = sext i32 %657 to i64
  %659 = inttoptr i64 %658 to i8*
  call void @push(%struct.Vector* %650, i8* %659)
  %660 = load %struct.Vector*, %struct.Vector** %40, align 8
  %661 = call i8* @dequeue(%struct.Vector* %660)
  br label %66

; <label>:662:                                    ; preds = %66
  br label %663

; <label>:663:                                    ; preds = %662, %66
  %664 = load %struct.Vector*, %struct.Vector** %7, align 8
  %665 = load %struct.Vector*, %struct.Vector** %7, align 8
  %666 = call i8* @pop(%struct.Vector* %665)
  %667 = ptrtoint i8* %666 to i64
  %668 = load %struct.Vector*, %struct.Vector** %7, align 8
  %669 = call i8* @pop(%struct.Vector* %668)
  %670 = ptrtoint i8* %669 to i64
  %671 = icmp sgt i64 %667, %670
  %672 = zext i1 %671 to i32
  %673 = sext i32 %672 to i64
  %674 = inttoptr i64 %673 to i8*
  call void @push(%struct.Vector* %664, i8* %674)
  %675 = load %struct.Vector*, %struct.Vector** %40, align 8
  %676 = call i8* @dequeue(%struct.Vector* %675)
  br label %66

; <label>:677:                                    ; preds = %66
  %678 = load %struct.Vector*, %struct.Vector** %40, align 8
  %679 = call i8* @dequeue(%struct.Vector* %678)
  %680 = ptrtoint i8* %679 to i64
  store i64 %680, i64* %18, align 8
  %681 = load %struct.Vector*, %struct.Vector** %7, align 8
  %682 = call i8* @pop(%struct.Vector* %681)
  %683 = bitcast i8* %682 to %struct.Vector*
  store %struct.Vector* %683, %struct.Vector** %21, align 8
  %684 = load i64, i64* %18, align 8
  %685 = trunc i64 %684 to i32
  %686 = call %struct.Vector* @vector_init(i32 %685)
  store %struct.Vector* %686, %struct.Vector** %30, align 8
  %687 = load %struct.Vector*, %struct.Vector** %30, align 8
  %688 = getelementptr inbounds %struct.Vector, %struct.Vector* %687, i32 0, i32 1
  %689 = load i8**, i8*** %688, align 8
  %690 = bitcast i8** %689 to i8*
  %691 = load %struct.Vector*, %struct.Vector** %7, align 8
  %692 = getelementptr inbounds %struct.Vector, %struct.Vector* %691, i32 0, i32 1
  %693 = load i8**, i8*** %692, align 8
  %694 = load %struct.Vector*, %struct.Vector** %7, align 8
  %695 = getelementptr inbounds %struct.Vector, %struct.Vector* %694, i32 0, i32 3
  %696 = load i32, i32* %695, align 4
  %697 = sext i32 %696 to i64
  %698 = load i64, i64* %18, align 8
  %699 = sub nsw i64 %697, %698
  %700 = getelementptr inbounds i8*, i8** %693, i64 %699
  %701 = bitcast i8** %700 to i8*
  %702 = load i64, i64* %18, align 8
  %703 = mul i64 %702, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %690, i8* %701, i64 %703, i32 8, i1 false)
  %704 = load i64, i64* %18, align 8
  %705 = trunc i64 %704 to i32
  %706 = load %struct.Vector*, %struct.Vector** %30, align 8
  %707 = getelementptr inbounds %struct.Vector, %struct.Vector* %706, i32 0, i32 3
  store i32 %705, i32* %707, align 4
  %708 = load %struct.Vector*, %struct.Vector** %7, align 8
  %709 = getelementptr inbounds %struct.Vector, %struct.Vector* %708, i32 0, i32 3
  %710 = load i32, i32* %709, align 4
  %711 = sext i32 %710 to i64
  %712 = load i64, i64* %18, align 8
  %713 = sub nsw i64 %711, %712
  %714 = trunc i64 %713 to i32
  %715 = load %struct.Vector*, %struct.Vector** %7, align 8
  %716 = getelementptr inbounds %struct.Vector, %struct.Vector* %715, i32 0, i32 3
  store i32 %714, i32* %716, align 4
  %717 = load %struct.Vector*, %struct.Vector** %10, align 8
  %718 = load %struct.Vector*, %struct.Vector** %40, align 8
  %719 = bitcast %struct.Vector* %718 to i8*
  call void @push(%struct.Vector* %717, i8* %719)
  %720 = load %struct.Vector*, %struct.Vector** %11, align 8
  %721 = load %struct.Vector*, %struct.Vector** %8, align 8
  %722 = bitcast %struct.Vector* %721 to i8*
  call void @push(%struct.Vector* %720, i8* %722)
  %723 = load %struct.Vector*, %struct.Vector** %21, align 8
  %724 = call i8* @vector_ref(%struct.Vector* %723, i32 2)
  %725 = bitcast i8* %724 to %struct.Vector*
  %726 = call %struct.Vector* @vector_copy0(%struct.Vector* %725)
  store %struct.Vector* %726, %struct.Vector** %8, align 8
  %727 = load %struct.Vector*, %struct.Vector** %8, align 8
  %728 = load %struct.Vector*, %struct.Vector** %30, align 8
  %729 = bitcast %struct.Vector* %728 to i8*
  call void @push(%struct.Vector* %727, i8* %729)
  %730 = load %struct.Vector*, %struct.Vector** %21, align 8
  %731 = call i8* @vector_ref(%struct.Vector* %730, i32 1)
  %732 = bitcast i8* %731 to %struct.Vector*
  %733 = call %struct.Vector* @vector_copy1(%struct.Vector* %732)
  store %struct.Vector* %733, %struct.Vector** %40, align 8
  %734 = load %struct.Vector*, %struct.Vector** %40, align 8
  %735 = call i8* @dequeue(%struct.Vector* %734)
  br label %66

; <label>:736:                                    ; preds = %66
  %737 = load %struct.Vector*, %struct.Vector** %40, align 8
  %738 = call i8* @dequeue(%struct.Vector* %737)
  %739 = ptrtoint i8* %738 to i64
  store i64 %739, i64* %18, align 8
  %740 = load %struct.Vector*, %struct.Vector** %7, align 8
  %741 = call i8* @pop(%struct.Vector* %740)
  %742 = bitcast i8* %741 to %struct.Vector*
  store %struct.Vector* %742, %struct.Vector** %21, align 8
  %743 = load i64, i64* %18, align 8
  %744 = trunc i64 %743 to i32
  %745 = call %struct.Vector* @vector_init(i32 %744)
  store %struct.Vector* %745, %struct.Vector** %30, align 8
  %746 = load %struct.Vector*, %struct.Vector** %30, align 8
  %747 = getelementptr inbounds %struct.Vector, %struct.Vector* %746, i32 0, i32 1
  %748 = load i8**, i8*** %747, align 8
  %749 = bitcast i8** %748 to i8*
  %750 = load %struct.Vector*, %struct.Vector** %7, align 8
  %751 = getelementptr inbounds %struct.Vector, %struct.Vector* %750, i32 0, i32 1
  %752 = load i8**, i8*** %751, align 8
  %753 = load %struct.Vector*, %struct.Vector** %7, align 8
  %754 = getelementptr inbounds %struct.Vector, %struct.Vector* %753, i32 0, i32 3
  %755 = load i32, i32* %754, align 4
  %756 = sext i32 %755 to i64
  %757 = load i64, i64* %18, align 8
  %758 = sub nsw i64 %756, %757
  %759 = getelementptr inbounds i8*, i8** %752, i64 %758
  %760 = bitcast i8** %759 to i8*
  %761 = load i64, i64* %18, align 8
  %762 = mul i64 %761, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %749, i8* %760, i64 %762, i32 8, i1 false)
  %763 = load i64, i64* %18, align 8
  %764 = trunc i64 %763 to i32
  %765 = load %struct.Vector*, %struct.Vector** %30, align 8
  %766 = getelementptr inbounds %struct.Vector, %struct.Vector* %765, i32 0, i32 3
  store i32 %764, i32* %766, align 4
  %767 = load %struct.Vector*, %struct.Vector** %7, align 8
  %768 = getelementptr inbounds %struct.Vector, %struct.Vector* %767, i32 0, i32 3
  %769 = load i32, i32* %768, align 4
  %770 = sext i32 %769 to i64
  %771 = load i64, i64* %18, align 8
  %772 = sub nsw i64 %770, %771
  %773 = trunc i64 %772 to i32
  %774 = load %struct.Vector*, %struct.Vector** %7, align 8
  %775 = getelementptr inbounds %struct.Vector, %struct.Vector* %774, i32 0, i32 3
  store i32 %773, i32* %775, align 4
  %776 = load %struct.Vector*, %struct.Vector** %21, align 8
  %777 = call i8* @vector_ref(%struct.Vector* %776, i32 2)
  %778 = bitcast i8* %777 to %struct.Vector*
  %779 = call %struct.Vector* @vector_copy0(%struct.Vector* %778)
  store %struct.Vector* %779, %struct.Vector** %8, align 8
  %780 = load %struct.Vector*, %struct.Vector** %8, align 8
  %781 = load %struct.Vector*, %struct.Vector** %30, align 8
  %782 = bitcast %struct.Vector* %781 to i8*
  call void @push(%struct.Vector* %780, i8* %782)
  %783 = load %struct.Vector*, %struct.Vector** %21, align 8
  %784 = call i8* @vector_ref(%struct.Vector* %783, i32 1)
  %785 = bitcast i8* %784 to %struct.Vector*
  %786 = call %struct.Vector* @vector_copy1(%struct.Vector* %785)
  store %struct.Vector* %786, %struct.Vector** %40, align 8
  %787 = load %struct.Vector*, %struct.Vector** %40, align 8
  %788 = call i8* @dequeue(%struct.Vector* %787)
  br label %66

; <label>:789:                                    ; preds = %66
  %790 = load %struct.Vector*, %struct.Vector** %40, align 8
  %791 = call i8* @dequeue(%struct.Vector* %790)
  %792 = ptrtoint i8* %791 to i64
  store i64 %792, i64* %18, align 8
  %793 = load %struct.Vector*, %struct.Vector** %7, align 8
  %794 = call i8* @pop(%struct.Vector* %793)
  %795 = bitcast i8* %794 to i8* (%struct.Vector*)*
  store i8* (%struct.Vector*)* %795, i8* (%struct.Vector*)** %33, align 8
  %796 = load i64, i64* %18, align 8
  %797 = trunc i64 %796 to i32
  %798 = call %struct.Vector* @vector_init(i32 %797)
  store %struct.Vector* %798, %struct.Vector** %30, align 8
  %799 = load %struct.Vector*, %struct.Vector** %30, align 8
  %800 = getelementptr inbounds %struct.Vector, %struct.Vector* %799, i32 0, i32 1
  %801 = load i8**, i8*** %800, align 8
  %802 = bitcast i8** %801 to i8*
  %803 = load %struct.Vector*, %struct.Vector** %7, align 8
  %804 = getelementptr inbounds %struct.Vector, %struct.Vector* %803, i32 0, i32 1
  %805 = load i8**, i8*** %804, align 8
  %806 = load %struct.Vector*, %struct.Vector** %7, align 8
  %807 = getelementptr inbounds %struct.Vector, %struct.Vector* %806, i32 0, i32 3
  %808 = load i32, i32* %807, align 4
  %809 = sext i32 %808 to i64
  %810 = load i64, i64* %18, align 8
  %811 = sub nsw i64 %809, %810
  %812 = getelementptr inbounds i8*, i8** %805, i64 %811
  %813 = bitcast i8** %812 to i8*
  %814 = load i64, i64* %18, align 8
  %815 = mul i64 %814, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %802, i8* %813, i64 %815, i32 8, i1 false)
  %816 = load i64, i64* %18, align 8
  %817 = trunc i64 %816 to i32
  %818 = load %struct.Vector*, %struct.Vector** %30, align 8
  %819 = getelementptr inbounds %struct.Vector, %struct.Vector* %818, i32 0, i32 3
  store i32 %817, i32* %819, align 4
  %820 = load %struct.Vector*, %struct.Vector** %7, align 8
  %821 = getelementptr inbounds %struct.Vector, %struct.Vector* %820, i32 0, i32 3
  %822 = load i32, i32* %821, align 4
  %823 = sext i32 %822 to i64
  %824 = load i64, i64* %18, align 8
  %825 = sub nsw i64 %823, %824
  %826 = trunc i64 %825 to i32
  %827 = load %struct.Vector*, %struct.Vector** %7, align 8
  %828 = getelementptr inbounds %struct.Vector, %struct.Vector* %827, i32 0, i32 3
  store i32 %826, i32* %828, align 4
  %829 = load %struct.Vector*, %struct.Vector** %7, align 8
  %830 = load i8* (%struct.Vector*)*, i8* (%struct.Vector*)** %33, align 8
  %831 = load %struct.Vector*, %struct.Vector** %30, align 8
  %832 = call i8* %830(%struct.Vector* %831)
  call void @push(%struct.Vector* %829, i8* %832)
  %833 = load %struct.Vector*, %struct.Vector** %40, align 8
  %834 = call i8* @dequeue(%struct.Vector* %833)
  br label %66

; <label>:835:                                    ; preds = %66
  %836 = load %struct.Vector*, %struct.Vector** %11, align 8
  %837 = call i8* @pop(%struct.Vector* %836)
  %838 = bitcast i8* %837 to %struct.Vector*
  store %struct.Vector* %838, %struct.Vector** %8, align 8
  %839 = load %struct.Vector*, %struct.Vector** %10, align 8
  %840 = call i8* @pop(%struct.Vector* %839)
  %841 = bitcast i8* %840 to %struct.Vector*
  store %struct.Vector* %841, %struct.Vector** %40, align 8
  %842 = load %struct.Vector*, %struct.Vector** %40, align 8
  %843 = call i8* @dequeue(%struct.Vector* %842)
  br label %66

; <label>:844:                                    ; preds = %66
  %845 = load %struct.Vector*, %struct.Vector** %7, align 8
  %846 = call i8* @pop(%struct.Vector* %845)
  %847 = ptrtoint i8* %846 to i64
  store i64 %847, i64* %19, align 8
  %848 = load %struct.Vector*, %struct.Vector** %40, align 8
  %849 = call i8* @dequeue(%struct.Vector* %848)
  %850 = bitcast i8* %849 to %struct.Vector*
  store %struct.Vector* %850, %struct.Vector** %23, align 8
  %851 = load %struct.Vector*, %struct.Vector** %40, align 8
  %852 = call i8* @dequeue(%struct.Vector* %851)
  %853 = bitcast i8* %852 to %struct.Vector*
  store %struct.Vector* %853, %struct.Vector** %24, align 8
  %854 = load %struct.Vector*, %struct.Vector** %10, align 8
  %855 = load %struct.Vector*, %struct.Vector** %40, align 8
  %856 = bitcast %struct.Vector* %855 to i8*
  call void @push(%struct.Vector* %854, i8* %856)
  %857 = load i64, i64* %19, align 8
  %858 = icmp ne i64 %857, 0
  br i1 %858, label %859, label %863

; <label>:859:                                    ; preds = %844
  %860 = load %struct.Vector*, %struct.Vector** %23, align 8
  store %struct.Vector* %860, %struct.Vector** %40, align 8
  %861 = load %struct.Vector*, %struct.Vector** %40, align 8
  %862 = getelementptr inbounds %struct.Vector, %struct.Vector* %861, i32 0, i32 2
  store i32 0, i32* %862, align 8
  br label %867

; <label>:863:                                    ; preds = %844
  %864 = load %struct.Vector*, %struct.Vector** %24, align 8
  store %struct.Vector* %864, %struct.Vector** %40, align 8
  %865 = load %struct.Vector*, %struct.Vector** %40, align 8
  %866 = getelementptr inbounds %struct.Vector, %struct.Vector* %865, i32 0, i32 2
  store i32 0, i32* %866, align 8
  br label %867

; <label>:867:                                    ; preds = %863, %859
  %868 = load %struct.Vector*, %struct.Vector** %40, align 8
  %869 = call i8* @dequeue(%struct.Vector* %868)
  br label %66

; <label>:870:                                    ; preds = %66
  %871 = load %struct.Vector*, %struct.Vector** %7, align 8
  %872 = call i8* @pop(%struct.Vector* %871)
  %873 = ptrtoint i8* %872 to i64
  store i64 %873, i64* %19, align 8
  %874 = load %struct.Vector*, %struct.Vector** %40, align 8
  %875 = call i8* @dequeue(%struct.Vector* %874)
  %876 = bitcast i8* %875 to %struct.Vector*
  store %struct.Vector* %876, %struct.Vector** %23, align 8
  %877 = load %struct.Vector*, %struct.Vector** %40, align 8
  %878 = call i8* @dequeue(%struct.Vector* %877)
  %879 = bitcast i8* %878 to %struct.Vector*
  store %struct.Vector* %879, %struct.Vector** %24, align 8
  %880 = load i64, i64* %19, align 8
  %881 = icmp ne i64 %880, 0
  br i1 %881, label %882, label %885

; <label>:882:                                    ; preds = %870
  %883 = load %struct.Vector*, %struct.Vector** %23, align 8
  %884 = call %struct.Vector* @vector_copy1(%struct.Vector* %883)
  store %struct.Vector* %884, %struct.Vector** %40, align 8
  br label %888

; <label>:885:                                    ; preds = %870
  %886 = load %struct.Vector*, %struct.Vector** %24, align 8
  %887 = call %struct.Vector* @vector_copy1(%struct.Vector* %886)
  store %struct.Vector* %887, %struct.Vector** %40, align 8
  br label %888

; <label>:888:                                    ; preds = %885, %882
  %889 = load %struct.Vector*, %struct.Vector** %40, align 8
  %890 = call i8* @dequeue(%struct.Vector* %889)
  br label %66

; <label>:891:                                    ; preds = %66
  %892 = load %struct.Vector*, %struct.Vector** %10, align 8
  %893 = call i8* @pop(%struct.Vector* %892)
  %894 = bitcast i8* %893 to %struct.Vector*
  store %struct.Vector* %894, %struct.Vector** %40, align 8
  %895 = load %struct.Vector*, %struct.Vector** %40, align 8
  %896 = call i8* @dequeue(%struct.Vector* %895)
  br label %66

; <label>:897:                                    ; preds = %66
  %898 = load %struct.Vector*, %struct.Vector** %40, align 8
  %899 = call i8* @dequeue(%struct.Vector* %898)
  %900 = bitcast i8* %899 to %struct.Vector*
  store %struct.Vector* %900, %struct.Vector** %25, align 8
  %901 = call %struct.Vector* @vector_init(i32 4)
  store %struct.Vector* %901, %struct.Vector** %27, align 8
  %902 = load %struct.Vector*, %struct.Vector** %27, align 8
  call void @push(%struct.Vector* %902, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i32 0, i32 0))
  %903 = load %struct.Vector*, %struct.Vector** %27, align 8
  %904 = load %struct.Vector*, %struct.Vector** %25, align 8
  %905 = bitcast %struct.Vector* %904 to i8*
  call void @push(%struct.Vector* %903, i8* %905)
  %906 = load %struct.Vector*, %struct.Vector** %27, align 8
  %907 = load %struct.Vector*, %struct.Vector** %8, align 8
  %908 = bitcast %struct.Vector* %907 to i8*
  call void @push(%struct.Vector* %906, i8* %908)
  %909 = load %struct.Vector*, %struct.Vector** %7, align 8
  %910 = load %struct.Vector*, %struct.Vector** %27, align 8
  %911 = bitcast %struct.Vector* %910 to i8*
  call void @push(%struct.Vector* %909, i8* %911)
  %912 = load %struct.Vector*, %struct.Vector** %40, align 8
  %913 = call i8* @dequeue(%struct.Vector* %912)
  br label %66

; <label>:914:                                    ; preds = %66
  %915 = load %struct.Vector*, %struct.Vector** %40, align 8
  %916 = call i8* @dequeue(%struct.Vector* %915)
  %917 = ptrtoint i8* %916 to i64
  store i64 %917, i64* %18, align 8
  %918 = load i64, i64* %18, align 8
  %919 = trunc i64 %918 to i32
  %920 = call %struct.Vector* @vector_init(i32 %919)
  store %struct.Vector* %920, %struct.Vector** %30, align 8
  %921 = load %struct.Vector*, %struct.Vector** %30, align 8
  %922 = getelementptr inbounds %struct.Vector, %struct.Vector* %921, i32 0, i32 1
  %923 = load i8**, i8*** %922, align 8
  %924 = bitcast i8** %923 to i8*
  %925 = load %struct.Vector*, %struct.Vector** %7, align 8
  %926 = getelementptr inbounds %struct.Vector, %struct.Vector* %925, i32 0, i32 1
  %927 = load i8**, i8*** %926, align 8
  %928 = load %struct.Vector*, %struct.Vector** %7, align 8
  %929 = getelementptr inbounds %struct.Vector, %struct.Vector* %928, i32 0, i32 3
  %930 = load i32, i32* %929, align 4
  %931 = sext i32 %930 to i64
  %932 = load i64, i64* %18, align 8
  %933 = sub nsw i64 %931, %932
  %934 = getelementptr inbounds i8*, i8** %927, i64 %933
  %935 = bitcast i8** %934 to i8*
  %936 = load i64, i64* %18, align 8
  %937 = mul i64 %936, 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %924, i8* %935, i64 %937, i32 8, i1 false)
  %938 = load i64, i64* %18, align 8
  %939 = trunc i64 %938 to i32
  %940 = load %struct.Vector*, %struct.Vector** %30, align 8
  %941 = getelementptr inbounds %struct.Vector, %struct.Vector* %940, i32 0, i32 3
  store i32 %939, i32* %941, align 4
  %942 = load %struct.Vector*, %struct.Vector** %7, align 8
  %943 = getelementptr inbounds %struct.Vector, %struct.Vector* %942, i32 0, i32 3
  %944 = load i32, i32* %943, align 4
  %945 = sext i32 %944 to i64
  %946 = load i64, i64* %18, align 8
  %947 = sub nsw i64 %945, %946
  %948 = trunc i64 %947 to i32
  %949 = load %struct.Vector*, %struct.Vector** %7, align 8
  %950 = getelementptr inbounds %struct.Vector, %struct.Vector* %949, i32 0, i32 3
  store i32 %948, i32* %950, align 4
  %951 = load %struct.Vector*, %struct.Vector** %7, align 8
  %952 = load %struct.Vector*, %struct.Vector** %30, align 8
  %953 = bitcast %struct.Vector* %952 to i8*
  call void @push(%struct.Vector* %951, i8* %953)
  %954 = load %struct.Vector*, %struct.Vector** %40, align 8
  %955 = call i8* @dequeue(%struct.Vector* %954)
  br label %66

; <label>:956:                                    ; preds = %66
  %957 = load %struct.Vector*, %struct.Vector** %7, align 8
  %958 = call i8* @pop(%struct.Vector* %957)
  %959 = ptrtoint i8* %958 to i64
  store i64 %959, i64* %18, align 8
  %960 = load %struct.Vector*, %struct.Vector** %7, align 8
  %961 = load %struct.Vector*, %struct.Vector** %7, align 8
  %962 = call i8* @pop(%struct.Vector* %961)
  %963 = bitcast i8* %962 to %struct.Vector*
  %964 = load i64, i64* %18, align 8
  %965 = trunc i64 %964 to i32
  %966 = call i8* @vector_ref(%struct.Vector* %963, i32 %965)
  call void @push(%struct.Vector* %960, i8* %966)
  %967 = load %struct.Vector*, %struct.Vector** %40, align 8
  %968 = call i8* @dequeue(%struct.Vector* %967)
  br label %66

; <label>:969:                                    ; preds = %66
  %970 = load %struct.Vector*, %struct.Vector** %7, align 8
  %971 = call i8* @pop(%struct.Vector* %970)
  store i8* %971, i8** %32, align 8
  %972 = load %struct.Vector*, %struct.Vector** %7, align 8
  %973 = call i8* @pop(%struct.Vector* %972)
  %974 = ptrtoint i8* %973 to i64
  store i64 %974, i64* %18, align 8
  %975 = load %struct.Vector*, %struct.Vector** %7, align 8
  %976 = call i8* @pop(%struct.Vector* %975)
  %977 = bitcast i8* %976 to %struct.Vector*
  store %struct.Vector* %977, %struct.Vector** %30, align 8
  %978 = load %struct.Vector*, %struct.Vector** %30, align 8
  %979 = load i64, i64* %18, align 8
  %980 = trunc i64 %979 to i32
  %981 = load i8*, i8** %32, align 8
  %982 = bitcast i8* %981 to i8**
  call void @vector_set(%struct.Vector* %978, i32 %980, i8** %982)
  %983 = load %struct.Vector*, %struct.Vector** %7, align 8
  %984 = load i8*, i8** %32, align 8
  call void @push(%struct.Vector* %983, i8* %984)
  %985 = load %struct.Vector*, %struct.Vector** %40, align 8
  %986 = call i8* @dequeue(%struct.Vector* %985)
  br label %66

; <label>:987:                                    ; preds = %66
  %988 = load %struct.Vector*, %struct.Vector** %7, align 8
  %989 = call i8* @pop(%struct.Vector* %988)
  %990 = ptrtoint i8* %989 to i64
  store i64 %990, i64* %18, align 8
  %991 = load i64, i64* %18, align 8
  %992 = call %struct.Hash* @Hash_init(i64 %991)
  store %struct.Hash* %992, %struct.Hash** %34, align 8
  %993 = load %struct.Vector*, %struct.Vector** %7, align 8
  %994 = load %struct.Hash*, %struct.Hash** %34, align 8
  %995 = bitcast %struct.Hash* %994 to i8*
  call void @push(%struct.Vector* %993, i8* %995)
  %996 = load %struct.Vector*, %struct.Vector** %40, align 8
  %997 = call i8* @dequeue(%struct.Vector* %996)
  br label %66

; <label>:998:                                    ; preds = %66
  %999 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1000 = call i8* @pop(%struct.Vector* %999)
  %1001 = bitcast i8* %1000 to %struct.Symbol*
  store %struct.Symbol* %1001, %struct.Symbol** %13, align 8
  %1002 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1003 = call i8* @pop(%struct.Vector* %1002)
  %1004 = bitcast i8* %1003 to %struct.Hash*
  store %struct.Hash* %1004, %struct.Hash** %34, align 8
  %1005 = load %struct.Hash*, %struct.Hash** %34, align 8
  %1006 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %1007 = call i8** @Hash_get(%struct.Hash* %1005, %struct.Symbol* %1006)
  store i8** %1007, i8*** %31, align 8
  %1008 = icmp eq i8** %1007, null
  br i1 %1008, label %1009, label %1014

; <label>:1009:                                   ; preds = %998
  %1010 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %1011 = getelementptr inbounds %struct.Symbol, %struct.Symbol* %1010, i32 0, i32 1
  %1012 = load i8*, i8** %1011, align 8
  %1013 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i32 0, i32 0), i8* %1012)
  br label %1018

; <label>:1014:                                   ; preds = %998
  %1015 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1016 = load i8**, i8*** %31, align 8
  %1017 = load i8*, i8** %1016, align 8
  call void @push(%struct.Vector* %1015, i8* %1017)
  br label %1018

; <label>:1018:                                   ; preds = %1014, %1009
  %1019 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1020 = call i8* @dequeue(%struct.Vector* %1019)
  br label %66

; <label>:1021:                                   ; preds = %66
  %1022 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1023 = call i8* @pop(%struct.Vector* %1022)
  store i8* %1023, i8** %32, align 8
  %1024 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1025 = call i8* @pop(%struct.Vector* %1024)
  %1026 = bitcast i8* %1025 to %struct.Symbol*
  store %struct.Symbol* %1026, %struct.Symbol** %13, align 8
  %1027 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1028 = call i8* @pop(%struct.Vector* %1027)
  %1029 = bitcast i8* %1028 to %struct.Hash*
  store %struct.Hash* %1029, %struct.Hash** %34, align 8
  %1030 = load %struct.Hash*, %struct.Hash** %34, align 8
  %1031 = load %struct.Symbol*, %struct.Symbol** %13, align 8
  %1032 = load i8*, i8** %32, align 8
  %1033 = call i64 @Hash_put(%struct.Hash* %1030, %struct.Symbol* %1031, i8* %1032)
  %1034 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1035 = load i8*, i8** %32, align 8
  call void @push(%struct.Vector* %1034, i8* %1035)
  %1036 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1037 = call i8* @dequeue(%struct.Vector* %1036)
  br label %66

; <label>:1038:                                   ; preds = %66
  %1039 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1040 = call i8* @pop(%struct.Vector* %1039)
  store i8* %1040, i8** %32, align 8
  %1041 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1042 = call i8* @pop(%struct.Vector* %1041)
  %1043 = bitcast i8* %1042 to %struct.Vector*
  store %struct.Vector* %1043, %struct.Vector** %30, align 8
  %1044 = load %struct.Vector*, %struct.Vector** %30, align 8
  %1045 = load i8*, i8** %32, align 8
  call void @push(%struct.Vector* %1044, i8* %1045)
  %1046 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1047 = load i8*, i8** %32, align 8
  call void @push(%struct.Vector* %1046, i8* %1047)
  %1048 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1049 = call i8* @dequeue(%struct.Vector* %1048)
  br label %66

; <label>:1050:                                   ; preds = %66
  %1051 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1052 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1053 = call i8* @pop(%struct.Vector* %1052)
  %1054 = bitcast i8* %1053 to %struct.Vector*
  %1055 = call i8* @pop(%struct.Vector* %1054)
  call void @push(%struct.Vector* %1051, i8* %1055)
  %1056 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1057 = call i8* @dequeue(%struct.Vector* %1056)
  br label %66

; <label>:1058:                                   ; preds = %66
  %1059 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1060 = call i8* @pop(%struct.Vector* %1059)
  %1061 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1062 = call i8* @dequeue(%struct.Vector* %1061)
  br label %66

; <label>:1063:                                   ; preds = %66
  %1064 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1065 = getelementptr inbounds %struct.Vector, %struct.Vector* %1064, i32 0, i32 1
  %1066 = load i8**, i8*** %1065, align 8
  %1067 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1068 = getelementptr inbounds %struct.Vector, %struct.Vector* %1067, i32 0, i32 3
  %1069 = load i32, i32* %1068, align 4
  %1070 = sub nsw i32 %1069, 1
  %1071 = sext i32 %1070 to i64
  %1072 = getelementptr inbounds i8*, i8** %1066, i64 %1071
  %1073 = load i8*, i8** %1072, align 8
  %1074 = bitcast i8* %1073 to double*
  %1075 = load double, double* %1074, align 8
  %1076 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %1075)
  %1077 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1078 = call i8* @dequeue(%struct.Vector* %1077)
  br label %66

; <label>:1079:                                   ; preds = %66
  %1080 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1081 = getelementptr inbounds %struct.Vector, %struct.Vector* %1080, i32 0, i32 1
  %1082 = load i8**, i8*** %1081, align 8
  %1083 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1084 = getelementptr inbounds %struct.Vector, %struct.Vector* %1083, i32 0, i32 3
  %1085 = load i32, i32* %1084, align 4
  %1086 = sub nsw i32 %1085, 1
  %1087 = sext i32 %1086 to i64
  %1088 = getelementptr inbounds i8*, i8** %1082, i64 %1087
  %1089 = load i8*, i8** %1088, align 8
  %1090 = bitcast i8* %1089 to %struct.__mpz_struct*
  %1091 = call i32 (i8*, ...) @__gmp_printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), %struct.__mpz_struct* %1090)
  %1092 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1093 = call i8* @dequeue(%struct.Vector* %1092)
  br label %66

; <label>:1094:                                   ; preds = %66
  %1095 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1096 = call i8* @pop(%struct.Vector* %1095)
  %1097 = bitcast i8* %1096 to %struct.Symbol*
  %1098 = getelementptr inbounds %struct.Symbol, %struct.Symbol* %1097, i32 0, i32 1
  %1099 = load i8*, i8** %1098, align 8
  %1100 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0), i8* %1099)
  %1101 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1102 = call i8* @dequeue(%struct.Vector* %1101)
  br label %66

; <label>:1103:                                   ; preds = %66
  %1104 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1105 = getelementptr inbounds %struct.Vector, %struct.Vector* %1104, i32 0, i32 1
  %1106 = load i8**, i8*** %1105, align 8
  %1107 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1108 = getelementptr inbounds %struct.Vector, %struct.Vector* %1107, i32 0, i32 3
  %1109 = load i32, i32* %1108, align 4
  %1110 = sub nsw i32 %1109, 1
  %1111 = sext i32 %1110 to i64
  %1112 = getelementptr inbounds i8*, i8** %1106, i64 %1111
  %1113 = load i8*, i8** %1112, align 8
  %1114 = bitcast i8* %1113 to %struct.object*
  %1115 = call i8* @objtostr(%struct.object* %1114)
  %1116 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0), i8* %1115)
  %1117 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1118 = call i8* @dequeue(%struct.Vector* %1117)
  br label %66

; <label>:1119:                                   ; preds = %66
  %1120 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1121 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1122 = getelementptr inbounds %struct.Vector, %struct.Vector* %1121, i32 0, i32 1
  %1123 = load i8**, i8*** %1122, align 8
  %1124 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1125 = getelementptr inbounds %struct.Vector, %struct.Vector* %1124, i32 0, i32 3
  %1126 = load i32, i32* %1125, align 4
  %1127 = sub nsw i32 %1126, 1
  %1128 = sext i32 %1127 to i64
  %1129 = getelementptr inbounds i8*, i8** %1123, i64 %1128
  %1130 = load i8*, i8** %1129, align 8
  call void @push(%struct.Vector* %1120, i8* %1130)
  %1131 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1132 = call i8* @dequeue(%struct.Vector* %1131)
  br label %66

; <label>:1133:                                   ; preds = %66
  %1134 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1135 = getelementptr inbounds %struct.Vector, %struct.Vector* %1134, i32 0, i32 1
  %1136 = load i8**, i8*** %1135, align 8
  %1137 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1138 = getelementptr inbounds %struct.Vector, %struct.Vector* %1137, i32 0, i32 3
  %1139 = load i32, i32* %1138, align 4
  %1140 = sub nsw i32 %1139, 1
  %1141 = sext i32 %1140 to i64
  %1142 = getelementptr inbounds i8*, i8** %1136, i64 %1141
  %1143 = load i8*, i8** %1142, align 8
  store i8* %1143, i8** %32, align 8
  %1144 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1145 = getelementptr inbounds %struct.Vector, %struct.Vector* %1144, i32 0, i32 1
  %1146 = load i8**, i8*** %1145, align 8
  %1147 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1148 = getelementptr inbounds %struct.Vector, %struct.Vector* %1147, i32 0, i32 3
  %1149 = load i32, i32* %1148, align 4
  %1150 = sub nsw i32 %1149, 2
  %1151 = sext i32 %1150 to i64
  %1152 = getelementptr inbounds i8*, i8** %1146, i64 %1151
  %1153 = load i8*, i8** %1152, align 8
  %1154 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1155 = getelementptr inbounds %struct.Vector, %struct.Vector* %1154, i32 0, i32 1
  %1156 = load i8**, i8*** %1155, align 8
  %1157 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1158 = getelementptr inbounds %struct.Vector, %struct.Vector* %1157, i32 0, i32 3
  %1159 = load i32, i32* %1158, align 4
  %1160 = sub nsw i32 %1159, 1
  %1161 = sext i32 %1160 to i64
  %1162 = getelementptr inbounds i8*, i8** %1156, i64 %1161
  store i8* %1153, i8** %1162, align 8
  %1163 = load i8*, i8** %32, align 8
  %1164 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1165 = getelementptr inbounds %struct.Vector, %struct.Vector* %1164, i32 0, i32 1
  %1166 = load i8**, i8*** %1165, align 8
  %1167 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1168 = getelementptr inbounds %struct.Vector, %struct.Vector* %1167, i32 0, i32 3
  %1169 = load i32, i32* %1168, align 4
  %1170 = sub nsw i32 %1169, 2
  %1171 = sext i32 %1170 to i64
  %1172 = getelementptr inbounds i8*, i8** %1166, i64 %1171
  store i8* %1163, i8** %1172, align 8
  %1173 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1174 = call i8* @dequeue(%struct.Vector* %1173)
  br label %66

; <label>:1175:                                   ; preds = %66
  %1176 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1177 = getelementptr inbounds %struct.Vector, %struct.Vector* %1176, i32 0, i32 1
  %1178 = load i8**, i8*** %1177, align 8
  %1179 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1180 = getelementptr inbounds %struct.Vector, %struct.Vector* %1179, i32 0, i32 3
  %1181 = load i32, i32* %1180, align 4
  %1182 = sub nsw i32 %1181, 1
  %1183 = sext i32 %1182 to i64
  %1184 = getelementptr inbounds i8*, i8** %1178, i64 %1183
  %1185 = load i8*, i8** %1184, align 8
  store i8* %1185, i8** %32, align 8
  %1186 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1187 = getelementptr inbounds %struct.Vector, %struct.Vector* %1186, i32 0, i32 1
  %1188 = load i8**, i8*** %1187, align 8
  %1189 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1190 = getelementptr inbounds %struct.Vector, %struct.Vector* %1189, i32 0, i32 3
  %1191 = load i32, i32* %1190, align 4
  %1192 = sub nsw i32 %1191, 2
  %1193 = sext i32 %1192 to i64
  %1194 = getelementptr inbounds i8*, i8** %1188, i64 %1193
  %1195 = load i8*, i8** %1194, align 8
  %1196 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1197 = getelementptr inbounds %struct.Vector, %struct.Vector* %1196, i32 0, i32 1
  %1198 = load i8**, i8*** %1197, align 8
  %1199 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1200 = getelementptr inbounds %struct.Vector, %struct.Vector* %1199, i32 0, i32 3
  %1201 = load i32, i32* %1200, align 4
  %1202 = sub nsw i32 %1201, 1
  %1203 = sext i32 %1202 to i64
  %1204 = getelementptr inbounds i8*, i8** %1198, i64 %1203
  store i8* %1195, i8** %1204, align 8
  %1205 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1206 = getelementptr inbounds %struct.Vector, %struct.Vector* %1205, i32 0, i32 1
  %1207 = load i8**, i8*** %1206, align 8
  %1208 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1209 = getelementptr inbounds %struct.Vector, %struct.Vector* %1208, i32 0, i32 3
  %1210 = load i32, i32* %1209, align 4
  %1211 = sub nsw i32 %1210, 3
  %1212 = sext i32 %1211 to i64
  %1213 = getelementptr inbounds i8*, i8** %1207, i64 %1212
  %1214 = load i8*, i8** %1213, align 8
  %1215 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1216 = getelementptr inbounds %struct.Vector, %struct.Vector* %1215, i32 0, i32 1
  %1217 = load i8**, i8*** %1216, align 8
  %1218 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1219 = getelementptr inbounds %struct.Vector, %struct.Vector* %1218, i32 0, i32 3
  %1220 = load i32, i32* %1219, align 4
  %1221 = sub nsw i32 %1220, 2
  %1222 = sext i32 %1221 to i64
  %1223 = getelementptr inbounds i8*, i8** %1217, i64 %1222
  store i8* %1214, i8** %1223, align 8
  %1224 = load i8*, i8** %32, align 8
  %1225 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1226 = getelementptr inbounds %struct.Vector, %struct.Vector* %1225, i32 0, i32 1
  %1227 = load i8**, i8*** %1226, align 8
  %1228 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1229 = getelementptr inbounds %struct.Vector, %struct.Vector* %1228, i32 0, i32 3
  %1230 = load i32, i32* %1229, align 4
  %1231 = sub nsw i32 %1230, 3
  %1232 = sext i32 %1231 to i64
  %1233 = getelementptr inbounds i8*, i8** %1227, i64 %1232
  store i8* %1224, i8** %1233, align 8
  %1234 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1235 = call i8* @dequeue(%struct.Vector* %1234)
  br label %66

; <label>:1236:                                   ; preds = %66
  %1237 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1238 = getelementptr inbounds %struct.Vector, %struct.Vector* %1237, i32 0, i32 1
  %1239 = load i8**, i8*** %1238, align 8
  %1240 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1241 = getelementptr inbounds %struct.Vector, %struct.Vector* %1240, i32 0, i32 3
  %1242 = load i32, i32* %1241, align 4
  %1243 = sub nsw i32 %1242, 2
  %1244 = sext i32 %1243 to i64
  %1245 = getelementptr inbounds i8*, i8** %1239, i64 %1244
  %1246 = load i8*, i8** %1245, align 8
  store i8* %1246, i8** %32, align 8
  %1247 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1248 = getelementptr inbounds %struct.Vector, %struct.Vector* %1247, i32 0, i32 1
  %1249 = load i8**, i8*** %1248, align 8
  %1250 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1251 = getelementptr inbounds %struct.Vector, %struct.Vector* %1250, i32 0, i32 3
  %1252 = load i32, i32* %1251, align 4
  %1253 = sub nsw i32 %1252, 3
  %1254 = sext i32 %1253 to i64
  %1255 = getelementptr inbounds i8*, i8** %1249, i64 %1254
  %1256 = load i8*, i8** %1255, align 8
  %1257 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1258 = getelementptr inbounds %struct.Vector, %struct.Vector* %1257, i32 0, i32 1
  %1259 = load i8**, i8*** %1258, align 8
  %1260 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1261 = getelementptr inbounds %struct.Vector, %struct.Vector* %1260, i32 0, i32 3
  %1262 = load i32, i32* %1261, align 4
  %1263 = sub nsw i32 %1262, 2
  %1264 = sext i32 %1263 to i64
  %1265 = getelementptr inbounds i8*, i8** %1259, i64 %1264
  store i8* %1256, i8** %1265, align 8
  %1266 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1267 = getelementptr inbounds %struct.Vector, %struct.Vector* %1266, i32 0, i32 1
  %1268 = load i8**, i8*** %1267, align 8
  %1269 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1270 = getelementptr inbounds %struct.Vector, %struct.Vector* %1269, i32 0, i32 3
  %1271 = load i32, i32* %1270, align 4
  %1272 = sub nsw i32 %1271, 4
  %1273 = sext i32 %1272 to i64
  %1274 = getelementptr inbounds i8*, i8** %1268, i64 %1273
  %1275 = load i8*, i8** %1274, align 8
  %1276 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1277 = getelementptr inbounds %struct.Vector, %struct.Vector* %1276, i32 0, i32 1
  %1278 = load i8**, i8*** %1277, align 8
  %1279 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1280 = getelementptr inbounds %struct.Vector, %struct.Vector* %1279, i32 0, i32 3
  %1281 = load i32, i32* %1280, align 4
  %1282 = sub nsw i32 %1281, 3
  %1283 = sext i32 %1282 to i64
  %1284 = getelementptr inbounds i8*, i8** %1278, i64 %1283
  store i8* %1275, i8** %1284, align 8
  %1285 = load i8*, i8** %32, align 8
  %1286 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1287 = getelementptr inbounds %struct.Vector, %struct.Vector* %1286, i32 0, i32 1
  %1288 = load i8**, i8*** %1287, align 8
  %1289 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1290 = getelementptr inbounds %struct.Vector, %struct.Vector* %1289, i32 0, i32 3
  %1291 = load i32, i32* %1290, align 4
  %1292 = sub nsw i32 %1291, 4
  %1293 = sext i32 %1292 to i64
  %1294 = getelementptr inbounds i8*, i8** %1288, i64 %1293
  store i8* %1285, i8** %1294, align 8
  %1295 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1296 = call i8* @dequeue(%struct.Vector* %1295)
  br label %66

; <label>:1297:                                   ; preds = %66
  %1298 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1299 = call i8* @dequeue(%struct.Vector* %1298)
  %1300 = ptrtoint i8* %1299 to i64
  store i64 %1300, i64* %18, align 8
  %1301 = load %struct.Vector*, %struct.Vector** %10, align 8
  %1302 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1303 = bitcast %struct.Vector* %1302 to i8*
  call void @push(%struct.Vector* %1301, i8* %1303)
  %1304 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1305 = call i8* @pop(%struct.Vector* %1304)
  %1306 = bitcast i8* %1305 to %struct.Vector*
  store %struct.Vector* %1306, %struct.Vector** %40, align 8
  %1307 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1308 = getelementptr inbounds %struct.Vector, %struct.Vector* %1307, i32 0, i32 2
  store i32 0, i32* %1308, align 8
  %1309 = load %struct.Vector*, %struct.Vector** %41, align 8
  %1310 = load i64, i64* %20, align 8
  %1311 = inttoptr i64 %1310 to i8*
  call void @push(%struct.Vector* %1309, i8* %1311)
  %1312 = load %struct.Vector*, %struct.Vector** %41, align 8
  %1313 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1314 = getelementptr inbounds %struct.Vector, %struct.Vector* %1313, i32 0, i32 3
  %1315 = load i32, i32* %1314, align 4
  %1316 = sext i32 %1315 to i64
  %1317 = inttoptr i64 %1316 to i8*
  %1318 = load i64, i64* %18, align 8
  %1319 = sub i64 0, %1318
  %1320 = getelementptr i8, i8* %1317, i64 %1319
  call void @push(%struct.Vector* %1312, i8* %1320)
  %1321 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1322 = getelementptr inbounds %struct.Vector, %struct.Vector* %1321, i32 0, i32 3
  %1323 = load i32, i32* %1322, align 4
  %1324 = sext i32 %1323 to i64
  store i64 %1324, i64* %20, align 8
  %1325 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1326 = call i8* @dequeue(%struct.Vector* %1325)
  br label %66

; <label>:1327:                                   ; preds = %66
  %1328 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1329 = call i8* @dequeue(%struct.Vector* %1328)
  %1330 = ptrtoint i8* %1329 to i64
  store i64 %1330, i64* %18, align 8
  %1331 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1332 = call i8* @pop(%struct.Vector* %1331)
  %1333 = bitcast i8* %1332 to %struct.Vector*
  store %struct.Vector* %1333, %struct.Vector** %40, align 8
  %1334 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1335 = getelementptr inbounds %struct.Vector, %struct.Vector* %1334, i32 0, i32 2
  store i32 0, i32* %1335, align 8
  %1336 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1337 = getelementptr inbounds %struct.Vector, %struct.Vector* %1336, i32 0, i32 3
  %1338 = load i32, i32* %1337, align 4
  %1339 = sext i32 %1338 to i64
  store i64 %1339, i64* %20, align 8
  %1340 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1341 = call i8* @dequeue(%struct.Vector* %1340)
  br label %66

; <label>:1342:                                   ; preds = %66
  %1343 = load %struct.Vector*, %struct.Vector** %10, align 8
  %1344 = call i8* @pop(%struct.Vector* %1343)
  %1345 = bitcast i8* %1344 to %struct.Vector*
  store %struct.Vector* %1345, %struct.Vector** %40, align 8
  %1346 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1347 = getelementptr inbounds %struct.Vector, %struct.Vector* %1346, i32 0, i32 1
  %1348 = load i8**, i8*** %1347, align 8
  %1349 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1350 = getelementptr inbounds %struct.Vector, %struct.Vector* %1349, i32 0, i32 3
  %1351 = load i32, i32* %1350, align 4
  %1352 = sub nsw i32 %1351, 1
  %1353 = sext i32 %1352 to i64
  %1354 = getelementptr inbounds i8*, i8** %1348, i64 %1353
  %1355 = load i8*, i8** %1354, align 8
  store i8* %1355, i8** %32, align 8
  %1356 = load %struct.Vector*, %struct.Vector** %41, align 8
  %1357 = call i8* @pop(%struct.Vector* %1356)
  %1358 = ptrtoint i8* %1357 to i64
  %1359 = trunc i64 %1358 to i32
  %1360 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1361 = getelementptr inbounds %struct.Vector, %struct.Vector* %1360, i32 0, i32 3
  store i32 %1359, i32* %1361, align 4
  %1362 = load %struct.Vector*, %struct.Vector** %41, align 8
  %1363 = call i8* @pop(%struct.Vector* %1362)
  %1364 = ptrtoint i8* %1363 to i64
  store i64 %1364, i64* %20, align 8
  %1365 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1366 = load i8*, i8** %32, align 8
  call void @push(%struct.Vector* %1365, i8* %1366)
  %1367 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1368 = call i8* @dequeue(%struct.Vector* %1367)
  br label %66

; <label>:1369:                                   ; preds = %66
  %1370 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1371 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1372 = call i8* @dequeue(%struct.Vector* %1371)
  call void @push(%struct.Vector* %1370, i8* %1372)
  %1373 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1374 = call i8* @dequeue(%struct.Vector* %1373)
  br label %66

; <label>:1375:                                   ; preds = %66
  %1376 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1377 = call i8* @dequeue(%struct.Vector* %1376)
  %1378 = ptrtoint i8* %1377 to i64
  store i64 %1378, i64* %18, align 8
  %1379 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1380 = load %struct.Vector*, %struct.Vector** %7, align 8
  %1381 = getelementptr inbounds %struct.Vector, %struct.Vector* %1380, i32 0, i32 1
  %1382 = load i8**, i8*** %1381, align 8
  %1383 = load i64, i64* %20, align 8
  %1384 = load i64, i64* %18, align 8
  %1385 = sub nsw i64 %1383, %1384
  %1386 = sub nsw i64 %1385, 1
  %1387 = getelementptr inbounds i8*, i8** %1382, i64 %1386
  %1388 = load i8*, i8** %1387, align 8
  call void @push(%struct.Vector* %1379, i8* %1388)
  %1389 = load %struct.Vector*, %struct.Vector** %40, align 8
  %1390 = call i8* @dequeue(%struct.Vector* %1389)
  br label %66
}

declare %struct.Vector* @vector_init(i32) #1

; Function Attrs: allocsize(0)
declare noalias i8* @GC_malloc(i64) #2

declare void @__gmpz_init(%struct.__mpz_struct*) #1

declare i8* @pop(%struct.Vector*) #1

declare void @push(%struct.Vector*, i8*) #1

declare i8* @vector_ref(%struct.Vector*, i32) #1

declare i8** @Hash_get(%struct.Hash*, %struct.Symbol*) #1

declare i32 @printf(i8*, ...) #1

declare i64 @Hash_put(%struct.Hash*, %struct.Symbol*, i8*) #1

declare %struct.object* @objadd(%struct.object*, %struct.object*) #1

declare void @__gmpz_add(%struct.__mpz_struct*, %struct.__mpz_struct*, %struct.__mpz_struct*) #1

declare void @__gmpz_init_set(%struct.__mpz_struct*, %struct.__mpz_struct*) #1

declare void @__gmpz_init_set_si(%struct.__mpz_struct*, i64) #1

declare %struct.object* @newINT(i64) #1

declare %struct.object* @newLINT(%struct.__mpz_struct*) #1

declare %struct.object* @newFLT(double) #1

declare %struct.object* @newRAT_i(i64, i64) #1

declare %struct.object* @objsub(%struct.object*, %struct.object*) #1

declare void @__gmpz_sub(%struct.__mpz_struct*, %struct.__mpz_struct*, %struct.__mpz_struct*) #1

declare %struct.object* @objdec(%struct.object*) #1

declare %struct.object* @objinc(%struct.object*) #1

declare %struct.object* @objmul(%struct.object*, %struct.object*) #1

declare void @__gmpz_mul(%struct.__mpz_struct*, %struct.__mpz_struct*, %struct.__mpz_struct*) #1

declare %struct.object* @objdiv(%struct.object*, %struct.object*) #1

declare void @__gmpz_fdiv_q(%struct.__mpz_struct*, %struct.__mpz_struct*, %struct.__mpz_struct*) #1

declare i32 @objeq(%struct.object*, %struct.object*) #1

declare i32 @objle(%struct.object*, %struct.object*) #1

declare i32 @objlt(%struct.object*, %struct.object*) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

declare %struct.Vector* @vector_copy1(%struct.Vector*) #1

declare %struct.Hash* @Hash_init(i64) #1

declare i32 @__gmp_printf(i8*, ...) #1

declare i8* @objtostr(%struct.object*) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { allocsize(0) "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { allocsize(0) }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
