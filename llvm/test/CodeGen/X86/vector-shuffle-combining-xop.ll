; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx,+xop | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx2,+xop | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx,+xop | FileCheck %s --check-prefix=X64
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+xop | FileCheck %s --check-prefix=X64

declare <2 x double> @llvm.x86.xop.vpermil2pd(<2 x double>, <2 x double>, <2 x i64>, i8) nounwind readnone
declare <4 x double> @llvm.x86.xop.vpermil2pd.256(<4 x double>, <4 x double>, <4 x i64>, i8) nounwind readnone

declare <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float>, <4 x float>, <4 x i32>, i8) nounwind readnone
declare <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float>, <8 x float>, <8 x i32>, i8) nounwind readnone

declare <16 x i8> @llvm.x86.xop.vpperm(<16 x i8>, <16 x i8>, <16 x i8>) nounwind readnone

define <2 x double> @combine_vpermil2pd_identity(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: combine_vpermil2pd_identity:
; X32:       # BB#0:
; X32-NEXT:    vmovaps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2pd_identity:
; X64:       # BB#0:
; X64-NEXT:    vmovaps %xmm1, %xmm0
; X64-NEXT:    retq
  %res0 = call <2 x double> @llvm.x86.xop.vpermil2pd(<2 x double> %a1, <2 x double> %a0, <2 x i64> <i64 2, i64 0>, i8 0)
  %res1 = call <2 x double> @llvm.x86.xop.vpermil2pd(<2 x double> %res0, <2 x double> undef, <2 x i64> <i64 2, i64 0>, i8 0)
  ret <2 x double> %res1
}

define <4 x double> @combine_vpermil2pd256_identity(<4 x double> %a0, <4 x double> %a1) {
; X32-LABEL: combine_vpermil2pd256_identity:
; X32:       # BB#0:
; X32-NEXT:    vmovaps %ymm1, %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2pd256_identity:
; X64:       # BB#0:
; X64-NEXT:    vmovaps %ymm1, %ymm0
; X64-NEXT:    retq
  %res0 = call <4 x double> @llvm.x86.xop.vpermil2pd.256(<4 x double> %a1, <4 x double> %a0, <4 x i64> <i64 2, i64 0, i64 2, i64 0>, i8 0)
  %res1 = call <4 x double> @llvm.x86.xop.vpermil2pd.256(<4 x double> %res0, <4 x double> undef, <4 x i64> <i64 2, i64 0, i64 2, i64 0>, i8 0)
  ret <4 x double> %res1
}

define <4 x double> @combine_vpermil2pd256_0z73(<4 x double> %a0, <4 x double> %a1) {
; X32-LABEL: combine_vpermil2pd256_0z73:
; X32:       # BB#0:
; X32-NEXT:    vpermil2pd {{.*#+}} ymm0 = ymm0[0],zero,ymm1[3],ymm0[3]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2pd256_0z73:
; X64:       # BB#0:
; X64-NEXT:    vpermil2pd {{.*#+}} ymm0 = ymm0[0],zero,ymm1[3],ymm0[3]
; X64-NEXT:    retq
  %res0 = shufflevector <4 x double> %a0, <4 x double> %a1, <4 x i32> <i32 0, i32 undef, i32 7, i32 3>
  %res1 = shufflevector <4 x double> %res0, <4 x double> zeroinitializer, <4 x i32> <i32 0, i32 7, i32 2, i32 3>
  ret <4 x double> %res1
}

define <4 x float> @combine_vpermil2ps_identity(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: combine_vpermil2ps_identity:
; X32:       # BB#0:
; X32-NEXT:    vmovaps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps_identity:
; X64:       # BB#0:
; X64-NEXT:    vmovaps %xmm1, %xmm0
; X64-NEXT:    retq
  %res0 = call <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float> %a1, <4 x float> %a0, <4 x i32> <i32 3, i32 2, i32 1, i32 0>, i8 0)
  %res1 = call <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float> %res0, <4 x float> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>, i8 0)
  ret <4 x float> %res1
}

define <4 x float> @combine_vpermil2ps_1z74(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: combine_vpermil2ps_1z74:
; X32:       # BB#0:
; X32-NEXT:    vpermil2ps {{.*#+}} xmm0 = xmm0[1],zero,xmm1[3,0]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps_1z74:
; X64:       # BB#0:
; X64-NEXT:    vpermil2ps {{.*#+}} xmm0 = xmm0[1],zero,xmm1[3,0]
; X64-NEXT:    retq
  %res0 = call <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float> %a0, <4 x float> %a1, <4 x i32> <i32 1, i32 1, i32 7, i32 4>, i8 0)
  %res1 = shufflevector <4 x float> %res0, <4 x float> zeroinitializer, <4 x i32> <i32 0, i32 7, i32 2, i32 3>
  ret <4 x float> %res1
}

define <8 x float> @combine_vpermil2ps256_identity(<8 x float> %a0, <8 x float> %a1) {
; X32-LABEL: combine_vpermil2ps256_identity:
; X32:       # BB#0:
; X32-NEXT:    vmovaps %ymm1, %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps256_identity:
; X64:       # BB#0:
; X64-NEXT:    vmovaps %ymm1, %ymm0
; X64-NEXT:    retq
  %res0 = call <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float> %a1, <8 x float> %a0, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 1, i32 0, i32 3, i32 2>, i8 0)
  %res1 = call <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float> %res0, <8 x float> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 1, i32 0, i32 3, i32 2>, i8 0)
  ret <8 x float> %res1
}

define <8 x float> @combine_vpermil2ps256_08z945Az(<8 x float> %a0, <8 x float> %a1) {
; X32-LABEL: combine_vpermil2ps256_08z945Az:
; X32:       # BB#0:
; X32-NEXT:    vpermil2ps {{.*#+}} ymm0 = ymm0[0],ymm1[0],zero,ymm1[1],ymm0[4,5],ymm1[6],zero
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps256_08z945Az:
; X64:       # BB#0:
; X64-NEXT:    vpermil2ps {{.*#+}} ymm0 = ymm0[0],ymm1[0],zero,ymm1[1],ymm0[4,5],ymm1[6],zero
; X64-NEXT:    retq
  %res0 = call <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float> %a0, <8 x float> %a1, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 0, i32 1, i32 6, i32 7>, i8 0)
  %res1 = shufflevector <8 x float> %res0, <8 x float> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 8, i32 3, i32 4, i32 5, i32 6, i32 8>
  ret <8 x float> %res1
}

define <8 x float> @combine_vpermil2ps256_zero(<8 x float> %a0, <8 x float> %a1) {
; X32-LABEL: combine_vpermil2ps256_zero:
; X32:       # BB#0:
; X32-NEXT:    vxorps %ymm0, %ymm0, %ymm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps256_zero:
; X64:       # BB#0:
; X64-NEXT:    vxorps %ymm0, %ymm0, %ymm0
; X64-NEXT:    retq
  %res0 = call <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float> %a1, <8 x float> %a0, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 8, i32 9, i32 10, i32 11>, i8 2)
  ret <8 x float> %res0
}

define <4 x float> @combine_vpermil2ps_blend_with_zero(<4 x float> %a0, <4 x float> %a1) {
; X32-LABEL: combine_vpermil2ps_blend_with_zero:
; X32:       # BB#0:
; X32-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X32-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0],xmm0[1,2,3]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2ps_blend_with_zero:
; X64:       # BB#0:
; X64-NEXT:    vxorps %xmm1, %xmm1, %xmm1
; X64-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0],xmm0[1,2,3]
; X64-NEXT:    retq
  %res0 = call <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float> %a0, <4 x float> %a1, <4 x i32> <i32 8, i32 1, i32 2, i32 3>, i8 2)
  ret <4 x float> %res0
}

define <2 x double> @combine_vpermil2pd_as_shufpd(<2 x double> %a0, <2 x double> %a1) {
; X32-LABEL: combine_vpermil2pd_as_shufpd:
; X32:       # BB#0:
; X32-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1],xmm1[0]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2pd_as_shufpd:
; X64:       # BB#0:
; X64-NEXT:    vshufpd {{.*#+}} xmm0 = xmm0[1],xmm1[0]
; X64-NEXT:    retq
  %res0 = call <2 x double> @llvm.x86.xop.vpermil2pd(<2 x double> %a0, <2 x double> %a1, <2 x i64> <i64 2, i64 4>, i8 0)
  ret <2 x double> %res0
}

define <4 x double> @combine_vpermil2pd256_as_shufpd(<4 x double> %a0, <4 x double> %a1) {
; X32-LABEL: combine_vpermil2pd256_as_shufpd:
; X32:       # BB#0:
; X32-NEXT:    vshufpd {{.*#+}} ymm0 = ymm0[0],ymm1[0],ymm0[3],ymm1[3]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpermil2pd256_as_shufpd:
; X64:       # BB#0:
; X64-NEXT:    vshufpd {{.*#+}} ymm0 = ymm0[0],ymm1[0],ymm0[3],ymm1[3]
; X64-NEXT:    retq
  %res0 = call <4 x double> @llvm.x86.xop.vpermil2pd.256(<4 x double> %a0, <4 x double> %a1, <4 x i64> <i64 0, i64 4, i64 2, i64 7>, i8 0)
  ret <4 x double> %res0
}

define <16 x i8> @combine_vpperm_identity(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_identity:
; X32:       # BB#0:
; X32-NEXT:    vmovaps %xmm1, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_identity:
; X64:       # BB#0:
; X64-NEXT:    vmovaps %xmm1, %xmm0
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> <i8 31, i8 30, i8 29, i8 28, i8 27, i8 26, i8 25, i8 24, i8 23, i8 22, i8 21, i8 20, i8 19, i8 18, i8 17, i8 16>)
  %res1 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %res0, <16 x i8> undef, <16 x i8> <i8 15, i8 14, i8 13, i8 12, i8 11, i8 10, i8 9, i8 8, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>)
  ret <16 x i8> %res1
}

define <16 x i8> @combine_vpperm_zero(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_zero:
; X32:       # BB#0:
; X32-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_zero:
; X64:       # BB#0:
; X64-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> <i8 128, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>)
  %res1 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %res0, <16 x i8> undef, <16 x i8> <i8 0, i8 128, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>)
  %res2 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %res1, <16 x i8> undef, <16 x i8> <i8 0, i8 1, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128, i8 128>)
  ret <16 x i8> %res2
}

define <16 x i8> @combine_vpperm_identity_bitcast(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_identity_bitcast:
; X32:       # BB#0:
; X32-NEXT:    vpaddq {{\.LCPI.*}}, %xmm0, %xmm0
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_identity_bitcast:
; X64:       # BB#0:
; X64-NEXT:    vpaddq {{.*}}(%rip), %xmm0, %xmm0
; X64-NEXT:    retq
  %mask = bitcast <2 x i64> <i64 1084818905618843912, i64 506097522914230528> to <16 x i8>
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> %mask)
  %res1 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %res0, <16 x i8> undef, <16 x i8> %mask)
  %res2 = bitcast <16 x i8> %res1 to <2 x i64>
  %res3 = add <2 x i64> %res2, <i64 1084818905618843912, i64 506097522914230528>
  %res4 = bitcast <2 x i64> %res3 to <16 x i8>
  ret <16 x i8> %res4
}

define <16 x i8> @combine_vpperm_as_blend_with_zero(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_as_blend_with_zero:
; X32:       # BB#0:
; X32-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; X32-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2,3],xmm1[4,5,6,7]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_as_blend_with_zero:
; X64:       # BB#0:
; X64-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; X64-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm1[1],xmm0[2,3],xmm1[4,5,6,7]
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> <i8 0, i8 1, i8 128, i8 129, i8 4, i8 5, i8 6, i8 7, i8 130, i8 131, i8 132, i8 133, i8 134, i8 135, i8 136, i8 137>)
  ret <16 x i8> %res0
}

define <16 x i8> @combine_vpperm_as_unary_unpckhbw(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_as_unary_unpckhbw:
; X32:       # BB#0:
; X32-NEXT:    vpunpckhbw {{.*#+}} xmm0 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_as_unary_unpckhbw:
; X64:       # BB#0:
; X64-NEXT:    vpunpckhbw {{.*#+}} xmm0 = xmm0[8,8,9,9,10,10,11,11,12,12,13,13,14,14,15,15]
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a0, <16 x i8> <i8 8, i8 undef, i8 9, i8 25, i8 10, i8 26, i8 11, i8 27, i8 12, i8 28, i8 13, i8 29, i8 14, i8 30, i8 15, i8 31>)
  ret <16 x i8> %res0
}

define <16 x i8> @combine_vpperm_as_unpckhbw(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_as_unpckhbw:
; X32:       # BB#0:
; X32-NEXT:    vpunpckhbw {{.*#+}} xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_as_unpckhbw:
; X64:       # BB#0:
; X64-NEXT:    vpunpckhbw {{.*#+}} xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> <i8 8, i8 24, i8 9, i8 25, i8 10, i8 26, i8 11, i8 27, i8 12, i8 28, i8 13, i8 29, i8 14, i8 30, i8 15, i8 31>)
  ret <16 x i8> %res0
}

define <16 x i8> @combine_vpperm_as_unpcklbw(<16 x i8> %a0, <16 x i8> %a1) {
; X32-LABEL: combine_vpperm_as_unpcklbw:
; X32:       # BB#0:
; X32-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_as_unpcklbw:
; X64:       # BB#0:
; X64-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1],xmm1[2],xmm0[2],xmm1[3],xmm0[3],xmm1[4],xmm0[4],xmm1[5],xmm0[5],xmm1[6],xmm0[6],xmm1[7],xmm0[7]
; X64-NEXT:    retq
  %res0 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %a0, <16 x i8> %a1, <16 x i8> <i8 16, i8 0, i8 17, i8 1, i8 18, i8 2, i8 19, i8 3, i8 20, i8 4, i8 21, i8 5, i8 22, i8 6, i8 23, i8 7>)
  ret <16 x i8> %res0
}

define <4 x i32> @combine_vpperm_10zz32BA(<4 x i32> %a0, <4 x i32> %a1) {
; X32-LABEL: combine_vpperm_10zz32BA:
; X32:       # BB#0:
; X32-NEXT:    vpperm {{.*#+}} xmm0 = xmm0[2,3,0,1],zero,zero,zero,zero,xmm0[6,7,4,5],xmm1[6,7,4,5]
; X32-NEXT:    retl
;
; X64-LABEL: combine_vpperm_10zz32BA:
; X64:       # BB#0:
; X64-NEXT:    vpperm {{.*#+}} xmm0 = xmm0[2,3,0,1],zero,zero,zero,zero,xmm0[6,7,4,5],xmm1[6,7,4,5]
; X64-NEXT:    retq
  %res0 = shufflevector <4 x i32> %a0, <4 x i32> %a1, <4 x i32> <i32 0, i32 4, i32 1, i32 5>
  %res1 = bitcast <4 x i32> %res0 to <16 x i8>
  %res2 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> %res1, <16 x i8> undef, <16 x i8> <i8 2, i8 3, i8 0, i8 1, i8 128, i8 128, i8 128, i8 128, i8 10, i8 11, i8 8, i8 9, i8 14, i8 15, i8 12, i8 13>)
  %res3 = bitcast <16 x i8> %res2 to <4 x i32>
  ret <4 x i32> %res3
}

define void @buildvector_v4f23_0404(float %a, float %b, <4 x float>* %ptr) {
; X32-LABEL: buildvector_v4f23_0404:
; X32:       # BB#0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vmovsd {{.*#+}} xmm0 = mem[0],zero
; X32-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1],mem[0],xmm0[3]
; X32-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0,1,2],mem[0]
; X32-NEXT:    vmovaps %xmm0, (%eax)
; X32-NEXT:    retl
;
; X64-LABEL: buildvector_v4f23_0404:
; X64:       # BB#0:
; X64-NEXT:    vpermil2ps {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[0],xmm1[0]
; X64-NEXT:    vmovaps %xmm0, (%rdi)
; X64-NEXT:    retq
  %v0 = insertelement <4 x float> undef, float %a, i32 0
  %v1 = insertelement <4 x float> %v0,   float %b, i32 1
  %v2 = insertelement <4 x float> %v1,   float %a, i32 2
  %v3 = insertelement <4 x float> %v2,   float %b, i32 3
  store <4 x float> %v3, <4 x float>* %ptr
  ret void
}

define <2 x double> @constant_fold_vpermil2pd() {
; X32-LABEL: constant_fold_vpermil2pd:
; X32:       # BB#0:
; X32-NEXT:    vmovaps {{.*#+}} xmm0 = [-2.000000e+00,2.000000e+00]
; X32-NEXT:    retl
;
; X64-LABEL: constant_fold_vpermil2pd:
; X64:       # BB#0:
; X64-NEXT:    vmovaps {{.*#+}} xmm0 = [-2.000000e+00,2.000000e+00]
; X64-NEXT:    retq
  %1 = call <2 x double> @llvm.x86.xop.vpermil2pd(<2 x double> <double 1.0, double 2.0>, <2 x double> <double -2.0, double -1.0>, <2 x i64> <i64 4, i64 2>, i8 2)
  ret <2 x double> %1
}

define <4 x double> @constant_fold_vpermil2pd_256() {
; X32-LABEL: constant_fold_vpermil2pd_256:
; X32:       # BB#0:
; X32-NEXT:    vmovaps {{.*#+}} ymm0 = [-4.000000e+00,0.000000e+00,4.000000e+00,3.000000e+00]
; X32-NEXT:    retl
;
; X64-LABEL: constant_fold_vpermil2pd_256:
; X64:       # BB#0:
; X64-NEXT:    vmovaps {{.*#+}} ymm0 = [-4.000000e+00,0.000000e+00,4.000000e+00,3.000000e+00]
; X64-NEXT:    retq
  %1 = call <4 x double> @llvm.x86.xop.vpermil2pd.256(<4 x double> <double 1.0, double 2.0, double 3.0, double 4.0>, <4 x double> <double -4.0, double -3.0, double -2.0, double -1.0>, <4 x i64> <i64 4, i64 8, i64 2, i64 0>, i8 2)
  ret <4 x double> %1
}

define <4 x float> @constant_fold_vpermil2ps() {
; X32-LABEL: constant_fold_vpermil2ps:
; X32:       # BB#0:
; X32-NEXT:    vmovaps {{.*#+}} xmm0 = [-4.000000e+00,1.000000e+00,3.000000e+00,0.000000e+00]
; X32-NEXT:    retl
;
; X64-LABEL: constant_fold_vpermil2ps:
; X64:       # BB#0:
; X64-NEXT:    vmovaps {{.*#+}} xmm0 = [-4.000000e+00,1.000000e+00,3.000000e+00,0.000000e+00]
; X64-NEXT:    retq
  %1 = call <4 x float> @llvm.x86.xop.vpermil2ps(<4 x float> <float 1.0, float 2.0, float 3.0, float 4.0>, <4 x float> <float -4.0, float -3.0, float -2.0, float -1.0>, <4 x i32> <i32 4, i32 0, i32 2, i32 8>, i8 2)
  ret <4 x float> %1
}

define <8 x float> @constant_fold_vpermil2ps_256() {
; X32-LABEL: constant_fold_vpermil2ps_256:
; X32:       # BB#0:
; X32-NEXT:    vmovaps {{.*#+}} ymm0 = [-8.000000e+00,1.000000e+00,3.000000e+00,0.000000e+00,5.000000e+00,0.000000e+00,5.000000e+00,7.000000e+00]
; X32-NEXT:    retl
;
; X64-LABEL: constant_fold_vpermil2ps_256:
; X64:       # BB#0:
; X64-NEXT:    vmovaps {{.*#+}} ymm0 = [-8.000000e+00,1.000000e+00,3.000000e+00,0.000000e+00,5.000000e+00,0.000000e+00,5.000000e+00,7.000000e+00]
; X64-NEXT:    retq
  %1 = call <8 x float> @llvm.x86.xop.vpermil2ps.256(<8 x float> <float 1.0, float 2.0, float 3.0, float 4.0, float 5.0, float 6.0, float 7.0, float 8.0>, <8 x float> <float -8.0, float -7.0, float -6.0, float -5.0, float -4.0, float -3.0, float -2.0, float -1.0>, <8 x i32> <i32 4, i32 0, i32 2, i32 8, i32 0, i32 8, i32 0, i32 2>, i8 2)
  ret <8 x float> %1
}

define <16 x i8> @constant_fold_vpperm() {
; X32-LABEL: constant_fold_vpperm:
; X32:       # BB#0:
; X32-NEXT:    vmovaps {{.*#+}} xmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; X32-NEXT:    retl
;
; X64-LABEL: constant_fold_vpperm:
; X64:       # BB#0:
; X64-NEXT:    vmovaps {{.*#+}} xmm0 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
; X64-NEXT:    retq
  %1 = call <16 x i8> @llvm.x86.xop.vpperm(<16 x i8> <i8 0, i8 -1, i8 -2, i8 -3, i8 -4, i8 -5, i8 -6, i8 -7, i8 -8, i8 -9, i8 -10, i8 -11, i8 -12, i8 -13, i8 -14, i8 -15>, <16 x i8> <i8 15, i8 14, i8 13, i8 12, i8 11, i8 10, i8 9, i8 8, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>, <16 x i8> <i8 31, i8 30, i8 29, i8 28, i8 27, i8 26, i8 25, i8 24, i8 23, i8 22, i8 21, i8 20, i8 19, i8 18, i8 17, i8 16>)
  ret <16 x i8> %1
}

define <4 x float> @PR31296(i8* %in) {
; X32-LABEL: PR31296:
; X32:       # BB#0: # %entry
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    vmovss {{.*#+}} xmm0 = mem[0],zero,zero,zero
; X32-NEXT:    vmovaps {{.*#+}} xmm1 = <0,1,u,u>
; X32-NEXT:    vpermil2ps {{.*#+}} xmm0 = xmm0[0],xmm1[0,0,1]
; X32-NEXT:    retl
;
; X64-LABEL: PR31296:
; X64:       # BB#0: # %entry
; X64-NEXT:    movl (%rdi), %eax
; X64-NEXT:    vmovq %rax, %xmm0
; X64-NEXT:    vmovaps {{.*#+}} xmm1 = <0,1,u,u>
; X64-NEXT:    vpermil2ps {{.*#+}} xmm0 = xmm0[0],xmm1[0,0,1]
; X64-NEXT:    retq
entry:
  %0 = getelementptr i8, i8* %in, i32 0
  %1 = bitcast i8* %0 to i32*
  %2 = load i32, i32* %1
  %3 = zext i32 %2 to i128
  %4 = bitcast i128 %3 to <4 x float>
  %5 = shufflevector <4 x float> %4, <4 x float> <float 0.000000e+00, float 1.000000e+00, float undef, float undef>, <4 x i32> <i32 0, i32 4, i32 4, i32 5>
  ret <4 x float> %5
}
