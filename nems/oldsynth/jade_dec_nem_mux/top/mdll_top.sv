

module mdll_top #(
// parameters here
) (
// i/os here
  input ext_cki,  // (+) cmos clock input (reference clock input)
  input ext_ckib, // (-) cmos clock input (reference clock input)
  input ext_frefp, // (+) low-swing clock input (reference clock input)
  input ext_frefn, // (-) low-swing clock input (reference clock input)
  input ext_cki_jm,  // (+) cmos clock input (reference clock input) (jitter measurement)
  input ext_ckib_jm, // (-) cmos clock input (reference clock input) (jitter measurement)
  input ext_frefp_jm, // (+) low-swing clock input (reference clock input) (jitter measurement)
  input ext_frefn_jm, // (-) low-swing clock input (reference clock input) (jitter measurement)
  input clk_ext_in,       // external clock for aux osc (valid when aux_sel = 1)
  
  input ref_sel,          // select reference clock inputs ('1': ext_cki(b), '0': ext_frefp(n))
  input reset,  // reset for isynth (act Hi)
  input rstb, // reset for main osc (act Lo)
  input en_inj, // enable injection (act Hi)
  input en_osc,   // enable main oscillator (act Hi)

  input sel_bb_in,        // select clock source for BB control ('1': , '0': )
  input en_ext_tune,  // initizlize mtune externally (act Hi)
  input bypass_dcdl, // bypass coarse tune (act Hi)
  input loop_sel, // select loop algorithm ('1': BB, '0': TDC)

  input aux_sel,  // select auxilliary osc source ('1': ext_clk_in, '0': internal osc)
  input en_aux, // enable aux osc (act Hi)
  input aux_div,  // divider aux osc by 2 (act Hi)
  input [2:0] ndiv_aux,   // divider ratio of aux 
  input [4:0] aux_tune, // aux osc frequency control
 
  input [1:0] ndiv, // feedback divider control
  input [3:0] ndiv_fref,  // divider ratio of fref
  
  input [1:0] gain_ratio, // gain control in LF
  input [3:0] gain_ctrl,  // gain control in LF
  
  
  input [3:0] ctune0,  // ctune control input for main osc cell 0
  
  input [3:0] ctune1,  // ctune control input for main osc cell 1
  
  input [6:0] ext_mtune,  // external mtune (see en_ext_tune)
  
  input [2:0] m_str,  // control driving strength of fine delay cell
  
  
  input [1:0] en_dith,  // enable dithering
  input dith_sel,       // select dithering scheme ('1': PRS , '0': DSM)
  input en_dsm_lsb_dith,  // use PRS in DSM dithering (act Hi)
  input [2:0] ndiv_fout,  // divider ratio of fout (for generating dithering clock)
  
  input bypass_retimer,   // disable retimer (act Hi)
  input [1:0] sel_ph,     // select phase for retimer
  input [2:0] dith_retime,  // control dithering retiming point
  
  input bypass_bb,        // disable offset control in BB loop (act Hi)
  input bypass_tdc,       // disable offset control in TDC loop (act Hi)
  input [3:0] add_off,      // offset delay control
  
  input en_jm,    // enable jitter measurement
  input ref_sel_jm,       // select jitter measurement clock inputs ('1': ext_cki(b)_jm, '0': ext_frefp(n)_jm)
  input [5:0] ncycle_jm,  // run n cycles of fref to measure jitter

  input [31:0] mdll_reserved,    // reserved input register

  output aux_div_pad,     // aux osc output for monitoring purpose
  output fout_div_pad,    // divided clock of fref for monitoring purpose
  output fref_off_pad,    // fref for monitoring purpose
  output ffeed_pad,       // 
  
  output frefp_out_jm,    // (+) frefp for off-chip phase adjustment
  output frefn_out_jm,    // (-) frefp for off-chip phase adjustment

  output [3:0] mdllout_pad, // 4-phase MDLL outputs
  output [19:0] jm_out,   // number of 1's in jitter measurement
  output [12:0] lf_out    // LF output (MSB 7bits for mtune, LSB 6bits for dithering)
);


wire frefp_buf, frefn_buf;
wire frefp_buf_jm, frefn_buf_jm;
wire ck_aux_osc;
wire dither_out;
wire dither_retime;
wire mdllout;
wire [6:0] dith_retime_thm;
wire [6:0] m_str_thm;
wire [14:0] add_off_thm;
wire start;
wire start_off;
wire stop;
wire stop_off;
wire [14:0]  ctune_thm0, ctune_thm1;
wire [6:0] mtune;
wire [6:0] str_thm;
wire clk_err;
wire mdllout_div;
wire dout_bb;
wire dout_1b_tdc;
wire mdllout_dither_out;
wire mdllout_div_out;
wire fref_dcdl_out;


// synopsys dc_script_begin
// set_dont_touch { icore irefbuf irefbuf_jm}
// synopsys dc_script_end

/* COMMENT OUT ALL INNER MODULES. JUST WANT SHELL HERE
// clock bufer for reference clock inputs (structural)
ref_buf irefbuf( .vip(ext_frefp), .vin(ext_frefn), .cki(ext_cki), .ckib(ext_ckib), .outp(frefp_buf), .outn(frefn_buf), .ref_sel(ref_sel) );

// clock bufer for jitter measurement clock inputs (structural)
ref_buf irefbuf_jm( .vip(ext_frefp_jm), .vin(ext_frefn_jm), .cki(ext_cki_jm), .ckib(ext_ckib_jm), .outp(frefp_buf_jm), .outn(frefn_buf_jm), .ref_sel(ref_sel_jm) );

// mdll core
mdll_core_ulvt icore ( .mdllout_pad(mdllout_pad), .mdllout_dither_out(mdllout_dither_out), .mdllout_div_out(mdllout_div_out), .fref_dcdl_out(fref_dcdl_out), .clk_err(clk_err), .dout_bb(dout_bb), .dout_tdc(dout_1b_tdc), .sel_ph(sel_ph), .dither(dither_out), .bypass_retimer(bypass_retimer), .dith_retime_thm(dith_retime_thm), .mtune(mtune), .add_off_thm(add_off_thm), .bypass_dcdl(bypass_dcdl), .ctune_thm0(ctune_thm0), .ctune_thm1(ctune_thm1), .en_dith(en_dith), .en_osc(en_osc), .frefp_in(frefp_buf), .frefn_in(frefn_buf), .str_thm(m_str_thm), .reset(reset), .ndiv(ndiv), .en_inj(en_inj), .bypass_bb(bypass_bb), .bypass_tdc(bypass_tdc), .ck_aux_osc(ck_aux_osc), .sel_bb_in(sel_bb_in) );

// mdll tracking loop (synthsizable)
mdll_synth isynth (
  .rstb(rstb), 
  .aux_sel(aux_sel),
  .en_aux(en_aux),
  .en_aux_div(aux_div),
	.aux_tune(aux_tune),
  .ck_aux_osc(ck_aux_osc),
  .ck_aux_div_pad(aux_div_pad),
	.ctune0(ctune0),
	.ctune1(ctune1),
	.ctune_thm0(ctune_thm0),
	.ctune_thm1(ctune_thm1),
	.dith_retime(dith_retime),
	.dith_retime_thm(dith_retime_thm),
  .m_str(m_str),
  .m_str_thm(m_str_thm),
	.add_off(add_off),
	.add_off_thm(add_off_thm),
	.dith_sel(dith_sel),
	.en_dsm_lsb_dith(en_dsm_lsb_dith),
	.dither_out(dither_out),
	.mdllout(mdllout_dither_out),
	.mdllout_div(mdllout_div_out),
	.fref(fref_dcdl_out),
	.clk_err(clk_err),
	.en_ext_tune(en_ext_tune),
	.ext_mtune(ext_mtune),
	.en_inj(en_inj),
	.loop_sel(loop_sel),
	.ndiv_fref(ndiv_fref),
	.ndiv_aux(ndiv_aux),
	.ndiv_fout(ndiv_fout),
	.gain_ctrl(gain_ctrl),
	.gain_ratio(gain_ratio),
  .dout_bb(dout_bb),
  .dout_1b_tdc(dout_1b_tdc),
	.mtune(mtune),
	.clk_ext_in(clk_ext_in),
	.fout_div_pad(fout_div_pad),
	.fref_off_pad(fref_off_pad),
	.ffeed_pad(ffeed_pad) );
*/

endmodule

