//===-- SIIntrinsics.td - SI Intrinsic defs ----------------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// SI Intrinsic Definitions
//
//===----------------------------------------------------------------------===//


let TargetPrefix = "SI", isTarget = 1 in {

  def int_SI_tid : Intrinsic <[llvm_i32_ty], [], [IntrNoMem]>;
  def int_SI_packf16 : Intrinsic <[llvm_i32_ty], [llvm_float_ty, llvm_float_ty], [IntrNoMem]>;
  def int_SI_export : Intrinsic <[], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_float_ty, llvm_float_ty, llvm_float_ty, llvm_float_ty], []>;
  def int_SI_load_const : Intrinsic <[llvm_float_ty], [llvm_anyint_ty, llvm_i32_ty], [IntrNoMem]>;
  def int_SI_vs_load_input : Intrinsic <[llvm_v4f32_ty], [llvm_anyint_ty, llvm_i16_ty, llvm_i32_ty], [IntrNoMem]> ;

  // Fully-flexible TBUFFER_STORE_FORMAT_* except for the ADDR64 bit, which is not exposed
  def int_SI_tbuffer_store : Intrinsic <
    [],
    [llvm_anyint_ty, // rsrc(SGPR)
     llvm_anyint_ty, // vdata(VGPR), overloaded for types i32, v2i32, v4i32
     llvm_i32_ty,    // num_channels(imm), selects opcode suffix: 1=X, 2=XY, 3=XYZ, 4=XYZW
     llvm_i32_ty,    // vaddr(VGPR)
     llvm_i32_ty,    // soffset(SGPR)
     llvm_i32_ty,    // inst_offset(imm)
     llvm_i32_ty,    // dfmt(imm)
     llvm_i32_ty,    // nfmt(imm)
     llvm_i32_ty,    // offen(imm)
     llvm_i32_ty,    // idxen(imm)
     llvm_i32_ty,    // glc(imm)
     llvm_i32_ty,    // slc(imm)
     llvm_i32_ty],   // tfe(imm)
    []>;

  // Fully-flexible BUFFER_LOAD_DWORD_* except for the ADDR64 bit, which is not exposed
  def int_SI_buffer_load_dword : Intrinsic <
    [llvm_anyint_ty], // vdata(VGPR), overloaded for types i32, v2i32, v4i32
    [llvm_anyint_ty,  // rsrc(SGPR)
     llvm_anyint_ty,  // vaddr(VGPR)
     llvm_i32_ty,     // soffset(SGPR)
     llvm_i32_ty,     // inst_offset(imm)
     llvm_i32_ty,     // offen(imm)
     llvm_i32_ty,     // idxen(imm)
     llvm_i32_ty,     // glc(imm)
     llvm_i32_ty,     // slc(imm)
     llvm_i32_ty],    // tfe(imm)
    [IntrReadArgMem]>;

  def int_SI_sendmsg : Intrinsic <[], [llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;

  class Sample : Intrinsic <[llvm_v4f32_ty], [llvm_anyvector_ty, llvm_v32i8_ty, llvm_anyint_ty, llvm_i32_ty], [IntrNoMem]>;

  def int_SI_sample : Sample;
  def int_SI_sampleb : Sample;
  def int_SI_sampled : Sample;
  def int_SI_samplel : Sample;

  def int_SI_imageload : Intrinsic <[llvm_v4i32_ty], [llvm_anyvector_ty, llvm_v32i8_ty, llvm_i32_ty], [IntrNoMem]>;

  def int_SI_resinfo : Intrinsic <[llvm_v4i32_ty], [llvm_i32_ty, llvm_v32i8_ty, llvm_i32_ty], [IntrNoMem]>;

  /* Interpolation Intrinsics */

  def int_SI_fs_constant : Intrinsic <[llvm_float_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty], [IntrNoMem]>;
  def int_SI_fs_interp : Intrinsic <[llvm_float_ty], [llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_v2i32_ty], [IntrNoMem]>;

  /* Control flow Intrinsics */

  def int_SI_if : Intrinsic<[llvm_i64_ty], [llvm_i1_ty, llvm_empty_ty], []>;
  def int_SI_else : Intrinsic<[llvm_i64_ty], [llvm_i64_ty, llvm_empty_ty], []>;
  def int_SI_break : Intrinsic<[llvm_i64_ty], [llvm_i64_ty], []>;
  def int_SI_if_break : Intrinsic<[llvm_i64_ty], [llvm_i1_ty, llvm_i64_ty], []>;
  def int_SI_else_break : Intrinsic<[llvm_i64_ty], [llvm_i64_ty, llvm_i64_ty], []>;
  def int_SI_loop : Intrinsic<[], [llvm_i64_ty, llvm_empty_ty], []>;
  def int_SI_end_cf : Intrinsic<[], [llvm_i64_ty], []>;
}
