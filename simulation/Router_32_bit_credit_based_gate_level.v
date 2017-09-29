/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06-SP4
// Date      : Wed Sep 27 16:22:52 2017
/////////////////////////////////////////////////////////////


module FIFO_credit_based_DATA_WIDTH32_4 ( reset, clk, RX, valid_in, read_en_N, 
        read_en_E, read_en_W, read_en_S, read_en_L, credit_out, empty_out, 
        Data_out );
  input [31:0] RX;
  output [31:0] Data_out;
  input reset, clk, valid_in, read_en_N, read_en_E, read_en_W, read_en_S,
         read_en_L;
  output credit_out, empty_out;
  wire   read_en, N68, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103;
  wire   [3:0] read_pointer;
  wire   [3:0] write_pointer;
  wire   [31:0] FIFO_MEM_1;
  wire   [31:0] FIFO_MEM_2;
  wire   [31:0] FIFO_MEM_3;
  wire   [31:0] FIFO_MEM_4;
  wire   [3:0] write_pointer_in;
  wire   [3:0] read_pointer_in;
  assign N68 = read_en_E;

  DFPX1 \write_pointer_reg[0]  ( .D(write_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(write_pointer[0]), .QN(n103) );
  DFPX1 \read_pointer_reg[0]  ( .D(read_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(read_pointer[0]), .QN(n101) );
  DFCX1 \write_pointer_reg[1]  ( .D(write_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(write_pointer[1]), .QN(n99) );
  DFCX1 \write_pointer_reg[2]  ( .D(write_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(write_pointer[2]), .QN(n102) );
  DFCX1 \write_pointer_reg[3]  ( .D(write_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(write_pointer[3]), .QN(n96) );
  DFCX1 \read_pointer_reg[3]  ( .D(read_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(read_pointer[3]), .QN(n98) );
  DFCX1 \read_pointer_reg[1]  ( .D(read_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(read_pointer[1]), .QN(n100) );
  DFCX1 \read_pointer_reg[2]  ( .D(read_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(read_pointer[2]), .QN(n97) );
  DFCX1 \FIFO_MEM_1_reg[31]  ( .D(n109), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[31]) );
  DFCX1 \FIFO_MEM_1_reg[30]  ( .D(n110), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[30]) );
  DFCX1 \FIFO_MEM_1_reg[29]  ( .D(n111), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[29]) );
  DFCX1 \FIFO_MEM_1_reg[28]  ( .D(n112), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[28]) );
  DFCX1 \FIFO_MEM_1_reg[27]  ( .D(n113), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[27]) );
  DFCX1 \FIFO_MEM_1_reg[26]  ( .D(n114), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[26]) );
  DFCX1 \FIFO_MEM_1_reg[25]  ( .D(n115), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[25]) );
  DFCX1 \FIFO_MEM_1_reg[24]  ( .D(n116), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[24]) );
  DFCX1 \FIFO_MEM_1_reg[23]  ( .D(n117), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[23]) );
  DFCX1 \FIFO_MEM_1_reg[22]  ( .D(n118), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[22]) );
  DFCX1 \FIFO_MEM_1_reg[21]  ( .D(n119), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[21]) );
  DFCX1 \FIFO_MEM_1_reg[20]  ( .D(n120), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[20]) );
  DFCX1 \FIFO_MEM_1_reg[19]  ( .D(n121), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[19]) );
  DFCX1 \FIFO_MEM_1_reg[18]  ( .D(n122), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[18]) );
  DFCX1 \FIFO_MEM_1_reg[17]  ( .D(n123), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[17]) );
  DFCX1 \FIFO_MEM_1_reg[16]  ( .D(n124), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[16]) );
  DFCX1 \FIFO_MEM_1_reg[15]  ( .D(n125), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[15]) );
  DFCX1 \FIFO_MEM_1_reg[14]  ( .D(n126), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[14]) );
  DFCX1 \FIFO_MEM_1_reg[13]  ( .D(n127), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[13]) );
  DFCX1 \FIFO_MEM_1_reg[12]  ( .D(n128), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[12]) );
  DFCX1 \FIFO_MEM_1_reg[11]  ( .D(n129), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[11]) );
  DFCX1 \FIFO_MEM_1_reg[10]  ( .D(n130), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[10]) );
  DFCX1 \FIFO_MEM_1_reg[9]  ( .D(n131), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[9]) );
  DFCX1 \FIFO_MEM_1_reg[8]  ( .D(n132), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[8]) );
  DFCX1 \FIFO_MEM_1_reg[7]  ( .D(n133), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[7]) );
  DFCX1 \FIFO_MEM_1_reg[6]  ( .D(n134), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[6]) );
  DFCX1 \FIFO_MEM_1_reg[5]  ( .D(n135), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[5]) );
  DFCX1 \FIFO_MEM_1_reg[4]  ( .D(n136), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[4]) );
  DFCX1 \FIFO_MEM_1_reg[3]  ( .D(n137), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[3]) );
  DFCX1 \FIFO_MEM_1_reg[2]  ( .D(n138), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[2]) );
  DFCX1 \FIFO_MEM_1_reg[1]  ( .D(n139), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[1]) );
  DFCX1 \FIFO_MEM_1_reg[0]  ( .D(n140), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[0]) );
  DFCX1 \FIFO_MEM_2_reg[31]  ( .D(n141), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[31]) );
  DFCX1 \FIFO_MEM_2_reg[30]  ( .D(n142), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[30]) );
  DFCX1 \FIFO_MEM_2_reg[29]  ( .D(n143), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[29]) );
  DFCX1 \FIFO_MEM_2_reg[28]  ( .D(n144), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[28]) );
  DFCX1 \FIFO_MEM_2_reg[27]  ( .D(n145), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[27]) );
  DFCX1 \FIFO_MEM_2_reg[26]  ( .D(n146), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[26]) );
  DFCX1 \FIFO_MEM_2_reg[25]  ( .D(n147), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[25]) );
  DFCX1 \FIFO_MEM_2_reg[24]  ( .D(n148), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[24]) );
  DFCX1 \FIFO_MEM_2_reg[23]  ( .D(n149), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[23]) );
  DFCX1 \FIFO_MEM_2_reg[22]  ( .D(n150), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[22]) );
  DFCX1 \FIFO_MEM_2_reg[21]  ( .D(n151), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[21]) );
  DFCX1 \FIFO_MEM_2_reg[20]  ( .D(n152), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[20]) );
  DFCX1 \FIFO_MEM_2_reg[19]  ( .D(n153), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[19]) );
  DFCX1 \FIFO_MEM_2_reg[18]  ( .D(n154), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[18]) );
  DFCX1 \FIFO_MEM_2_reg[17]  ( .D(n155), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[17]) );
  DFCX1 \FIFO_MEM_2_reg[16]  ( .D(n156), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[16]) );
  DFCX1 \FIFO_MEM_2_reg[15]  ( .D(n157), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[15]) );
  DFCX1 \FIFO_MEM_2_reg[14]  ( .D(n158), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[14]) );
  DFCX1 \FIFO_MEM_2_reg[13]  ( .D(n159), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[13]) );
  DFCX1 \FIFO_MEM_2_reg[12]  ( .D(n160), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[12]) );
  DFCX1 \FIFO_MEM_2_reg[11]  ( .D(n161), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[11]) );
  DFCX1 \FIFO_MEM_2_reg[10]  ( .D(n162), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[10]) );
  DFCX1 \FIFO_MEM_2_reg[9]  ( .D(n163), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[9]) );
  DFCX1 \FIFO_MEM_2_reg[8]  ( .D(n164), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[8]) );
  DFCX1 \FIFO_MEM_2_reg[7]  ( .D(n165), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[7]) );
  DFCX1 \FIFO_MEM_2_reg[6]  ( .D(n166), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[6]) );
  DFCX1 \FIFO_MEM_2_reg[5]  ( .D(n167), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[5]) );
  DFCX1 \FIFO_MEM_2_reg[4]  ( .D(n168), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[4]) );
  DFCX1 \FIFO_MEM_2_reg[3]  ( .D(n169), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[3]) );
  DFCX1 \FIFO_MEM_2_reg[2]  ( .D(n170), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[2]) );
  DFCX1 \FIFO_MEM_2_reg[1]  ( .D(n171), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[1]) );
  DFCX1 \FIFO_MEM_2_reg[0]  ( .D(n172), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[0]) );
  DFCX1 \FIFO_MEM_3_reg[31]  ( .D(n173), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[31]) );
  DFCX1 \FIFO_MEM_3_reg[30]  ( .D(n174), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[30]) );
  DFCX1 \FIFO_MEM_3_reg[29]  ( .D(n175), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[29]) );
  DFCX1 \FIFO_MEM_3_reg[28]  ( .D(n176), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[28]) );
  DFCX1 \FIFO_MEM_3_reg[27]  ( .D(n177), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[27]) );
  DFCX1 \FIFO_MEM_3_reg[26]  ( .D(n178), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[26]) );
  DFCX1 \FIFO_MEM_3_reg[25]  ( .D(n179), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[25]) );
  DFCX1 \FIFO_MEM_3_reg[24]  ( .D(n180), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[24]) );
  DFCX1 \FIFO_MEM_3_reg[23]  ( .D(n181), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[23]) );
  DFCX1 \FIFO_MEM_3_reg[22]  ( .D(n182), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[22]) );
  DFCX1 \FIFO_MEM_3_reg[21]  ( .D(n183), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[21]) );
  DFCX1 \FIFO_MEM_3_reg[20]  ( .D(n184), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[20]) );
  DFCX1 \FIFO_MEM_3_reg[19]  ( .D(n185), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[19]) );
  DFCX1 \FIFO_MEM_3_reg[18]  ( .D(n186), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[18]) );
  DFCX1 \FIFO_MEM_3_reg[17]  ( .D(n187), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[17]) );
  DFCX1 \FIFO_MEM_3_reg[16]  ( .D(n188), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[16]) );
  DFCX1 \FIFO_MEM_3_reg[15]  ( .D(n189), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[15]) );
  DFCX1 \FIFO_MEM_3_reg[14]  ( .D(n190), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[14]) );
  DFCX1 \FIFO_MEM_3_reg[13]  ( .D(n191), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[13]) );
  DFCX1 \FIFO_MEM_3_reg[12]  ( .D(n192), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[12]) );
  DFCX1 \FIFO_MEM_3_reg[11]  ( .D(n193), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[11]) );
  DFCX1 \FIFO_MEM_3_reg[10]  ( .D(n194), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[10]) );
  DFCX1 \FIFO_MEM_3_reg[9]  ( .D(n195), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[9]) );
  DFCX1 \FIFO_MEM_3_reg[8]  ( .D(n196), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[8]) );
  DFCX1 \FIFO_MEM_3_reg[7]  ( .D(n197), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[7]) );
  DFCX1 \FIFO_MEM_3_reg[6]  ( .D(n198), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[6]) );
  DFCX1 \FIFO_MEM_3_reg[5]  ( .D(n199), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[5]) );
  DFCX1 \FIFO_MEM_3_reg[4]  ( .D(n200), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[4]) );
  DFCX1 \FIFO_MEM_3_reg[3]  ( .D(n201), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[3]) );
  DFCX1 \FIFO_MEM_3_reg[2]  ( .D(n202), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[2]) );
  DFCX1 \FIFO_MEM_3_reg[1]  ( .D(n203), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[1]) );
  DFCX1 \FIFO_MEM_3_reg[0]  ( .D(n204), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[0]) );
  DFCX1 \FIFO_MEM_4_reg[31]  ( .D(n205), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[31]) );
  DFCX1 \FIFO_MEM_4_reg[30]  ( .D(n206), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[30]) );
  DFCX1 \FIFO_MEM_4_reg[29]  ( .D(n207), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[29]) );
  DFCX1 \FIFO_MEM_4_reg[28]  ( .D(n208), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[28]) );
  DFCX1 \FIFO_MEM_4_reg[27]  ( .D(n209), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[27]) );
  DFCX1 \FIFO_MEM_4_reg[26]  ( .D(n210), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[26]) );
  DFCX1 \FIFO_MEM_4_reg[25]  ( .D(n211), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[25]) );
  DFCX1 \FIFO_MEM_4_reg[24]  ( .D(n212), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[24]) );
  DFCX1 \FIFO_MEM_4_reg[23]  ( .D(n213), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[23]) );
  DFCX1 \FIFO_MEM_4_reg[22]  ( .D(n214), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[22]) );
  DFCX1 \FIFO_MEM_4_reg[21]  ( .D(n215), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[21]) );
  DFCX1 \FIFO_MEM_4_reg[20]  ( .D(n216), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[20]) );
  DFCX1 \FIFO_MEM_4_reg[19]  ( .D(n217), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[19]) );
  DFCX1 \FIFO_MEM_4_reg[18]  ( .D(n218), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[18]) );
  DFCX1 \FIFO_MEM_4_reg[17]  ( .D(n219), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[17]) );
  DFCX1 \FIFO_MEM_4_reg[16]  ( .D(n220), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[16]) );
  DFCX1 \FIFO_MEM_4_reg[15]  ( .D(n221), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[15]) );
  DFCX1 \FIFO_MEM_4_reg[14]  ( .D(n222), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[14]) );
  DFCX1 \FIFO_MEM_4_reg[13]  ( .D(n223), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[13]) );
  DFCX1 \FIFO_MEM_4_reg[12]  ( .D(n224), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[12]) );
  DFCX1 \FIFO_MEM_4_reg[11]  ( .D(n225), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[11]) );
  DFCX1 \FIFO_MEM_4_reg[10]  ( .D(n226), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[10]) );
  DFCX1 \FIFO_MEM_4_reg[9]  ( .D(n227), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[9]) );
  DFCX1 \FIFO_MEM_4_reg[8]  ( .D(n228), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[8]) );
  DFCX1 \FIFO_MEM_4_reg[7]  ( .D(n229), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[7]) );
  DFCX1 \FIFO_MEM_4_reg[6]  ( .D(n230), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[6]) );
  DFCX1 \FIFO_MEM_4_reg[5]  ( .D(n231), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[5]) );
  DFCX1 \FIFO_MEM_4_reg[4]  ( .D(n232), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[4]) );
  DFCX1 \FIFO_MEM_4_reg[3]  ( .D(n233), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[3]) );
  DFCX1 \FIFO_MEM_4_reg[2]  ( .D(n234), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[2]) );
  DFCX1 \FIFO_MEM_4_reg[1]  ( .D(n235), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[1]) );
  DFCX1 \FIFO_MEM_4_reg[0]  ( .D(n236), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[0]) );
  DFCX1 credit_out_reg ( .D(read_en), .CP(clk), .RN(reset), .Q(credit_out) );
  INVX2 U3 ( .A(n82), .Q(n81) );
  NOR3X8 U4 ( .A(n7), .B(n73), .C(n72), .Q(n14) );
  NAND2XL U5 ( .A(n101), .B(n100), .Q(n6) );
  AOI22X1 U6 ( .A1(FIFO_MEM_2[29]), .A2(n72), .B1(FIFO_MEM_1[29]), .B2(n71), 
        .Q(n13) );
  AOI22X1 U7 ( .A1(read_en), .A2(n98), .B1(n101), .B2(n93), .Q(
        read_pointer_in[0]) );
  AO22X1 U8 ( .A1(RX[31]), .A2(n82), .B1(FIFO_MEM_4[31]), .B2(n81), .Q(n205)
         );
  AO22X1 U9 ( .A1(n82), .A2(RX[0]), .B1(FIFO_MEM_4[0]), .B2(n81), .Q(n236) );
  AO22X1 U10 ( .A1(RX[1]), .A2(n82), .B1(FIFO_MEM_4[1]), .B2(n81), .Q(n235) );
  AO22X1 U11 ( .A1(RX[2]), .A2(n82), .B1(FIFO_MEM_4[2]), .B2(n81), .Q(n234) );
  AO22X1 U12 ( .A1(RX[3]), .A2(n82), .B1(FIFO_MEM_4[3]), .B2(n81), .Q(n233) );
  AO22X1 U13 ( .A1(RX[4]), .A2(n82), .B1(FIFO_MEM_4[4]), .B2(n81), .Q(n232) );
  AO22X1 U14 ( .A1(RX[30]), .A2(n82), .B1(FIFO_MEM_4[30]), .B2(n81), .Q(n206)
         );
  AO22X1 U15 ( .A1(RX[5]), .A2(n82), .B1(FIFO_MEM_4[5]), .B2(n81), .Q(n231) );
  AO22X1 U16 ( .A1(RX[29]), .A2(n82), .B1(FIFO_MEM_4[29]), .B2(n81), .Q(n207)
         );
  AO22X1 U17 ( .A1(RX[6]), .A2(n82), .B1(FIFO_MEM_4[6]), .B2(n81), .Q(n230) );
  AO22X1 U18 ( .A1(RX[7]), .A2(n82), .B1(FIFO_MEM_4[7]), .B2(n81), .Q(n229) );
  AO22X1 U19 ( .A1(RX[8]), .A2(n82), .B1(FIFO_MEM_4[8]), .B2(n81), .Q(n228) );
  AO22X1 U20 ( .A1(RX[9]), .A2(n82), .B1(FIFO_MEM_4[9]), .B2(n81), .Q(n227) );
  AO22X1 U21 ( .A1(RX[28]), .A2(n82), .B1(FIFO_MEM_4[28]), .B2(n81), .Q(n208)
         );
  AO22X1 U22 ( .A1(RX[27]), .A2(n82), .B1(FIFO_MEM_4[27]), .B2(n81), .Q(n209)
         );
  AO22X1 U23 ( .A1(RX[10]), .A2(n82), .B1(FIFO_MEM_4[10]), .B2(n81), .Q(n226)
         );
  AO22X1 U24 ( .A1(RX[11]), .A2(n82), .B1(FIFO_MEM_4[11]), .B2(n81), .Q(n225)
         );
  AO22X1 U25 ( .A1(RX[12]), .A2(n82), .B1(FIFO_MEM_4[12]), .B2(n81), .Q(n224)
         );
  AO22X1 U26 ( .A1(RX[13]), .A2(n82), .B1(FIFO_MEM_4[13]), .B2(n81), .Q(n223)
         );
  AO22X1 U27 ( .A1(RX[26]), .A2(n82), .B1(FIFO_MEM_4[26]), .B2(n81), .Q(n210)
         );
  AO22X1 U28 ( .A1(RX[14]), .A2(n82), .B1(FIFO_MEM_4[14]), .B2(n81), .Q(n222)
         );
  AO22X1 U29 ( .A1(RX[15]), .A2(n82), .B1(FIFO_MEM_4[15]), .B2(n81), .Q(n221)
         );
  AO22X1 U30 ( .A1(RX[16]), .A2(n82), .B1(FIFO_MEM_4[16]), .B2(n81), .Q(n220)
         );
  AO22X1 U31 ( .A1(RX[25]), .A2(n82), .B1(FIFO_MEM_4[25]), .B2(n81), .Q(n211)
         );
  AO22X1 U32 ( .A1(RX[17]), .A2(n82), .B1(FIFO_MEM_4[17]), .B2(n81), .Q(n219)
         );
  AO22X1 U33 ( .A1(RX[18]), .A2(n82), .B1(FIFO_MEM_4[18]), .B2(n81), .Q(n218)
         );
  AO22X1 U34 ( .A1(RX[19]), .A2(n82), .B1(FIFO_MEM_4[19]), .B2(n81), .Q(n217)
         );
  AO22X1 U35 ( .A1(RX[20]), .A2(n82), .B1(FIFO_MEM_4[20]), .B2(n81), .Q(n216)
         );
  AO22X1 U36 ( .A1(RX[24]), .A2(n82), .B1(FIFO_MEM_4[24]), .B2(n81), .Q(n212)
         );
  AO22X1 U37 ( .A1(RX[21]), .A2(n82), .B1(FIFO_MEM_4[21]), .B2(n81), .Q(n215)
         );
  AO22X1 U38 ( .A1(RX[22]), .A2(n82), .B1(FIFO_MEM_4[22]), .B2(n81), .Q(n214)
         );
  AO22X1 U39 ( .A1(RX[23]), .A2(n82), .B1(FIFO_MEM_4[23]), .B2(n81), .Q(n213)
         );
  NAND2X3 U40 ( .A(valid_in), .B(n79), .Q(n94) );
  AOI221X3 U41 ( .A1(write_pointer[3]), .A2(n98), .B1(n96), .B2(
        read_pointer[3]), .C1(n4), .Q(empty_out) );
  OAI221X2 U42 ( .A1(write_pointer[2]), .A2(n98), .B1(n102), .B2(
        read_pointer[3]), .C1(n78), .Q(n79) );
  AOI221X2 U43 ( .A1(write_pointer[1]), .A2(n97), .B1(n99), .B2(
        read_pointer[2]), .C1(n77), .Q(n78) );
  CLKINVX2 U44 ( .A(n85), .Q(n1) );
  NAND2X2 U45 ( .A(n9), .B(n8), .Q(Data_out[31]) );
  CLKINVX2 U46 ( .A(read_en), .Q(n93) );
  NOR3X4 U47 ( .A(read_pointer[3]), .B(n97), .C(n6), .Q(n7) );
  NAND2XL U48 ( .A(n11), .B(n10), .Q(Data_out[16]) );
  NOR2X3 U49 ( .A(n88), .B(n94), .Q(n90) );
  NOR2X3 U50 ( .A(n86), .B(n94), .Q(n92) );
  NOR2XL U51 ( .A(n103), .B(n94), .Q(n83) );
  NOR3X4 U52 ( .A(read_pointer[2]), .B(n98), .C(n6), .Q(n73) );
  CLKBUFX2 U53 ( .A(n14), .Q(n71) );
  AOI221X1 U54 ( .A1(n99), .A2(read_pointer[1]), .B1(write_pointer[0]), .B2(
        n101), .C1(n2), .Q(n3) );
  CLKINVX2 U55 ( .A(n90), .Q(n89) );
  CLKINVX2 U56 ( .A(n92), .Q(n91) );
  NOR2XL U57 ( .A(empty_out), .B(n5), .Q(read_en) );
  NOR4X1 U58 ( .A(N68), .B(read_en_W), .C(read_en_S), .D(read_en_L), .Q(n5) );
  AO22X1 U59 ( .A1(RX[0]), .A2(n90), .B1(FIFO_MEM_3[0]), .B2(n89), .Q(n204) );
  AO22X1 U60 ( .A1(RX[1]), .A2(n90), .B1(FIFO_MEM_3[1]), .B2(n89), .Q(n203) );
  AO22X1 U61 ( .A1(RX[2]), .A2(n90), .B1(FIFO_MEM_3[2]), .B2(n89), .Q(n202) );
  AO22X1 U62 ( .A1(RX[3]), .A2(n90), .B1(FIFO_MEM_3[3]), .B2(n89), .Q(n201) );
  AO22X1 U63 ( .A1(RX[4]), .A2(n90), .B1(FIFO_MEM_3[4]), .B2(n89), .Q(n200) );
  AO22X1 U64 ( .A1(RX[5]), .A2(n90), .B1(FIFO_MEM_3[5]), .B2(n89), .Q(n199) );
  AO22X1 U65 ( .A1(RX[6]), .A2(n90), .B1(FIFO_MEM_3[6]), .B2(n89), .Q(n198) );
  AO22X1 U66 ( .A1(RX[7]), .A2(n90), .B1(FIFO_MEM_3[7]), .B2(n89), .Q(n197) );
  AO22X1 U67 ( .A1(RX[8]), .A2(n90), .B1(FIFO_MEM_3[8]), .B2(n89), .Q(n196) );
  AO22X1 U68 ( .A1(RX[9]), .A2(n90), .B1(FIFO_MEM_3[9]), .B2(n89), .Q(n195) );
  AO22X1 U69 ( .A1(RX[10]), .A2(n90), .B1(FIFO_MEM_3[10]), .B2(n89), .Q(n194)
         );
  AO22X1 U70 ( .A1(RX[11]), .A2(n90), .B1(FIFO_MEM_3[11]), .B2(n89), .Q(n193)
         );
  AO22X1 U71 ( .A1(RX[12]), .A2(n90), .B1(FIFO_MEM_3[12]), .B2(n89), .Q(n192)
         );
  AO22X1 U72 ( .A1(RX[13]), .A2(n90), .B1(FIFO_MEM_3[13]), .B2(n89), .Q(n191)
         );
  AO22X1 U73 ( .A1(RX[14]), .A2(n90), .B1(FIFO_MEM_3[14]), .B2(n89), .Q(n190)
         );
  AO22X1 U74 ( .A1(RX[15]), .A2(n90), .B1(FIFO_MEM_3[15]), .B2(n89), .Q(n189)
         );
  AO22X1 U75 ( .A1(RX[16]), .A2(n90), .B1(FIFO_MEM_3[16]), .B2(n89), .Q(n188)
         );
  AO22X1 U76 ( .A1(RX[17]), .A2(n90), .B1(FIFO_MEM_3[17]), .B2(n89), .Q(n187)
         );
  AO22X1 U77 ( .A1(RX[18]), .A2(n90), .B1(FIFO_MEM_3[18]), .B2(n89), .Q(n186)
         );
  AO22X1 U78 ( .A1(RX[19]), .A2(n90), .B1(FIFO_MEM_3[19]), .B2(n89), .Q(n185)
         );
  AO22X1 U79 ( .A1(RX[20]), .A2(n90), .B1(FIFO_MEM_3[20]), .B2(n89), .Q(n184)
         );
  AO22X1 U80 ( .A1(RX[21]), .A2(n90), .B1(FIFO_MEM_3[21]), .B2(n89), .Q(n183)
         );
  AO22X1 U81 ( .A1(RX[22]), .A2(n90), .B1(FIFO_MEM_3[22]), .B2(n89), .Q(n182)
         );
  AO22X1 U82 ( .A1(RX[23]), .A2(n90), .B1(FIFO_MEM_3[23]), .B2(n89), .Q(n181)
         );
  AO22X1 U83 ( .A1(RX[24]), .A2(n90), .B1(FIFO_MEM_3[24]), .B2(n89), .Q(n180)
         );
  AO22X1 U84 ( .A1(RX[25]), .A2(n90), .B1(FIFO_MEM_3[25]), .B2(n89), .Q(n179)
         );
  AO22X1 U85 ( .A1(RX[26]), .A2(n90), .B1(FIFO_MEM_3[26]), .B2(n89), .Q(n178)
         );
  AO22X1 U86 ( .A1(RX[27]), .A2(n90), .B1(FIFO_MEM_3[27]), .B2(n89), .Q(n177)
         );
  AO22X1 U87 ( .A1(RX[28]), .A2(n90), .B1(FIFO_MEM_3[28]), .B2(n89), .Q(n176)
         );
  AO22X1 U88 ( .A1(RX[29]), .A2(n90), .B1(FIFO_MEM_3[29]), .B2(n89), .Q(n175)
         );
  AO22X1 U89 ( .A1(RX[30]), .A2(n90), .B1(FIFO_MEM_3[30]), .B2(n89), .Q(n174)
         );
  AO22X1 U90 ( .A1(RX[31]), .A2(n90), .B1(FIFO_MEM_3[31]), .B2(n89), .Q(n173)
         );
  AO22X1 U91 ( .A1(RX[0]), .A2(n92), .B1(FIFO_MEM_2[0]), .B2(n91), .Q(n172) );
  AO22X1 U92 ( .A1(RX[1]), .A2(n92), .B1(FIFO_MEM_2[1]), .B2(n91), .Q(n171) );
  AO22X1 U93 ( .A1(RX[2]), .A2(n92), .B1(FIFO_MEM_2[2]), .B2(n91), .Q(n170) );
  AO22X1 U94 ( .A1(RX[3]), .A2(n92), .B1(FIFO_MEM_2[3]), .B2(n91), .Q(n169) );
  AO22X1 U95 ( .A1(RX[4]), .A2(n92), .B1(FIFO_MEM_2[4]), .B2(n91), .Q(n168) );
  AO22X1 U96 ( .A1(RX[5]), .A2(n92), .B1(FIFO_MEM_2[5]), .B2(n91), .Q(n167) );
  AO22X1 U97 ( .A1(RX[6]), .A2(n92), .B1(FIFO_MEM_2[6]), .B2(n91), .Q(n166) );
  AO22X1 U98 ( .A1(RX[7]), .A2(n92), .B1(FIFO_MEM_2[7]), .B2(n91), .Q(n165) );
  AO22X1 U99 ( .A1(RX[8]), .A2(n92), .B1(FIFO_MEM_2[8]), .B2(n91), .Q(n164) );
  AO22X1 U100 ( .A1(RX[9]), .A2(n92), .B1(FIFO_MEM_2[9]), .B2(n91), .Q(n163)
         );
  AO22X1 U101 ( .A1(RX[10]), .A2(n92), .B1(FIFO_MEM_2[10]), .B2(n91), .Q(n162)
         );
  AO22X1 U102 ( .A1(RX[11]), .A2(n92), .B1(FIFO_MEM_2[11]), .B2(n91), .Q(n161)
         );
  AO22X1 U103 ( .A1(RX[12]), .A2(n92), .B1(FIFO_MEM_2[12]), .B2(n91), .Q(n160)
         );
  AO22X1 U104 ( .A1(RX[13]), .A2(n92), .B1(FIFO_MEM_2[13]), .B2(n91), .Q(n159)
         );
  AO22X1 U105 ( .A1(RX[14]), .A2(n92), .B1(FIFO_MEM_2[14]), .B2(n91), .Q(n158)
         );
  AO22X1 U106 ( .A1(RX[15]), .A2(n92), .B1(FIFO_MEM_2[15]), .B2(n91), .Q(n157)
         );
  AO22X1 U107 ( .A1(RX[16]), .A2(n92), .B1(FIFO_MEM_2[16]), .B2(n91), .Q(n156)
         );
  AO22X1 U108 ( .A1(RX[17]), .A2(n92), .B1(FIFO_MEM_2[17]), .B2(n91), .Q(n155)
         );
  AO22X1 U109 ( .A1(RX[18]), .A2(n92), .B1(FIFO_MEM_2[18]), .B2(n91), .Q(n154)
         );
  AO22X1 U110 ( .A1(RX[19]), .A2(n92), .B1(FIFO_MEM_2[19]), .B2(n91), .Q(n153)
         );
  AO22X1 U111 ( .A1(RX[20]), .A2(n92), .B1(FIFO_MEM_2[20]), .B2(n91), .Q(n152)
         );
  AO22X1 U112 ( .A1(RX[21]), .A2(n92), .B1(FIFO_MEM_2[21]), .B2(n91), .Q(n151)
         );
  AO22X1 U113 ( .A1(RX[22]), .A2(n92), .B1(FIFO_MEM_2[22]), .B2(n91), .Q(n150)
         );
  AO22X1 U114 ( .A1(RX[23]), .A2(n92), .B1(FIFO_MEM_2[23]), .B2(n91), .Q(n149)
         );
  AO22X1 U115 ( .A1(RX[24]), .A2(n92), .B1(FIFO_MEM_2[24]), .B2(n91), .Q(n148)
         );
  AO22X1 U116 ( .A1(RX[25]), .A2(n92), .B1(FIFO_MEM_2[25]), .B2(n91), .Q(n147)
         );
  AO22X1 U117 ( .A1(RX[26]), .A2(n92), .B1(FIFO_MEM_2[26]), .B2(n91), .Q(n146)
         );
  AO22X1 U118 ( .A1(RX[27]), .A2(n92), .B1(FIFO_MEM_2[27]), .B2(n91), .Q(n145)
         );
  AO22X1 U119 ( .A1(RX[28]), .A2(n92), .B1(FIFO_MEM_2[28]), .B2(n91), .Q(n144)
         );
  AO22X1 U120 ( .A1(RX[29]), .A2(n92), .B1(FIFO_MEM_2[29]), .B2(n91), .Q(n143)
         );
  AO22X1 U121 ( .A1(RX[30]), .A2(n92), .B1(FIFO_MEM_2[30]), .B2(n91), .Q(n142)
         );
  AO22X1 U122 ( .A1(RX[31]), .A2(n92), .B1(FIFO_MEM_2[31]), .B2(n91), .Q(n141)
         );
  AO22X1 U123 ( .A1(n85), .A2(RX[0]), .B1(n1), .B2(FIFO_MEM_1[0]), .Q(n140) );
  AO22X1 U124 ( .A1(n85), .A2(RX[1]), .B1(n1), .B2(FIFO_MEM_1[1]), .Q(n139) );
  AO22X1 U125 ( .A1(n85), .A2(RX[2]), .B1(n1), .B2(FIFO_MEM_1[2]), .Q(n138) );
  AO22X1 U126 ( .A1(n85), .A2(RX[3]), .B1(n1), .B2(FIFO_MEM_1[3]), .Q(n137) );
  AO22X1 U127 ( .A1(n85), .A2(RX[4]), .B1(n1), .B2(FIFO_MEM_1[4]), .Q(n136) );
  AO22X1 U128 ( .A1(n85), .A2(RX[5]), .B1(n1), .B2(FIFO_MEM_1[5]), .Q(n135) );
  AO22X1 U129 ( .A1(n85), .A2(RX[6]), .B1(n1), .B2(FIFO_MEM_1[6]), .Q(n134) );
  AO22X1 U130 ( .A1(n85), .A2(RX[7]), .B1(n1), .B2(FIFO_MEM_1[7]), .Q(n133) );
  AO22X1 U131 ( .A1(n85), .A2(RX[8]), .B1(n1), .B2(FIFO_MEM_1[8]), .Q(n132) );
  AO22X1 U132 ( .A1(n85), .A2(RX[9]), .B1(n1), .B2(FIFO_MEM_1[9]), .Q(n131) );
  AO22X1 U133 ( .A1(n85), .A2(RX[10]), .B1(n1), .B2(FIFO_MEM_1[10]), .Q(n130)
         );
  AO22X1 U134 ( .A1(n85), .A2(RX[11]), .B1(n1), .B2(FIFO_MEM_1[11]), .Q(n129)
         );
  AO22X1 U135 ( .A1(n85), .A2(RX[12]), .B1(n1), .B2(FIFO_MEM_1[12]), .Q(n128)
         );
  AO22X1 U136 ( .A1(n85), .A2(RX[13]), .B1(n1), .B2(FIFO_MEM_1[13]), .Q(n127)
         );
  AO22X1 U137 ( .A1(n85), .A2(RX[14]), .B1(n1), .B2(FIFO_MEM_1[14]), .Q(n126)
         );
  AO22X1 U138 ( .A1(n85), .A2(RX[15]), .B1(n1), .B2(FIFO_MEM_1[15]), .Q(n125)
         );
  AO22X1 U139 ( .A1(n85), .A2(RX[16]), .B1(n1), .B2(FIFO_MEM_1[16]), .Q(n124)
         );
  AO22X1 U140 ( .A1(n85), .A2(RX[17]), .B1(n1), .B2(FIFO_MEM_1[17]), .Q(n123)
         );
  AO22X1 U141 ( .A1(n85), .A2(RX[18]), .B1(n1), .B2(FIFO_MEM_1[18]), .Q(n122)
         );
  AO22X1 U142 ( .A1(n85), .A2(RX[19]), .B1(n1), .B2(FIFO_MEM_1[19]), .Q(n121)
         );
  AO22X1 U143 ( .A1(n85), .A2(RX[20]), .B1(n1), .B2(FIFO_MEM_1[20]), .Q(n120)
         );
  AO22X1 U144 ( .A1(n85), .A2(RX[21]), .B1(n1), .B2(FIFO_MEM_1[21]), .Q(n119)
         );
  AO22X1 U145 ( .A1(n85), .A2(RX[22]), .B1(n1), .B2(FIFO_MEM_1[22]), .Q(n118)
         );
  AO22X1 U146 ( .A1(n85), .A2(RX[23]), .B1(n1), .B2(FIFO_MEM_1[23]), .Q(n117)
         );
  AO22X1 U147 ( .A1(n85), .A2(RX[24]), .B1(n1), .B2(FIFO_MEM_1[24]), .Q(n116)
         );
  AO22X1 U148 ( .A1(n85), .A2(RX[25]), .B1(n1), .B2(FIFO_MEM_1[25]), .Q(n115)
         );
  AO22X1 U149 ( .A1(n85), .A2(RX[26]), .B1(n1), .B2(FIFO_MEM_1[26]), .Q(n114)
         );
  AO22X1 U150 ( .A1(n85), .A2(RX[27]), .B1(n1), .B2(FIFO_MEM_1[27]), .Q(n113)
         );
  AO22X1 U151 ( .A1(n85), .A2(RX[28]), .B1(n1), .B2(FIFO_MEM_1[28]), .Q(n112)
         );
  AO22X1 U152 ( .A1(n85), .A2(RX[29]), .B1(n1), .B2(FIFO_MEM_1[29]), .Q(n111)
         );
  AO22X1 U153 ( .A1(n85), .A2(RX[30]), .B1(n1), .B2(FIFO_MEM_1[30]), .Q(n110)
         );
  AO22X1 U154 ( .A1(n85), .A2(RX[31]), .B1(n1), .B2(FIFO_MEM_1[31]), .Q(n109)
         );
  AND3X2 U155 ( .A(n84), .B(n83), .C(n96), .Q(n85) );
  NOR2X3 U156 ( .A(n94), .B(n80), .Q(n82) );
  OAI22X1 U157 ( .A1(n99), .A2(read_pointer[1]), .B1(n101), .B2(
        write_pointer[0]), .Q(n2) );
  OAI221X1 U158 ( .A1(write_pointer[2]), .A2(n97), .B1(n102), .B2(
        read_pointer[2]), .C1(n3), .Q(n4) );
  NOR4X6 U159 ( .A(read_pointer[0]), .B(read_pointer[3]), .C(read_pointer[2]), 
        .D(n100), .Q(n72) );
  AOI22X1 U160 ( .A1(FIFO_MEM_2[31]), .A2(n72), .B1(FIFO_MEM_1[31]), .B2(n14), 
        .Q(n9) );
  AOI22X1 U161 ( .A1(FIFO_MEM_4[31]), .A2(n73), .B1(FIFO_MEM_3[31]), .B2(n7), 
        .Q(n8) );
  AOI22X1 U162 ( .A1(FIFO_MEM_2[16]), .A2(n72), .B1(FIFO_MEM_1[16]), .B2(n71), 
        .Q(n11) );
  AOI22X1 U163 ( .A1(FIFO_MEM_4[16]), .A2(n73), .B1(FIFO_MEM_3[16]), .B2(n7), 
        .Q(n10) );
  AOI22X1 U164 ( .A1(FIFO_MEM_4[29]), .A2(n73), .B1(FIFO_MEM_3[29]), .B2(n7), 
        .Q(n12) );
  NAND2X3 U165 ( .A(n13), .B(n12), .Q(Data_out[29]) );
  AOI22X1 U166 ( .A1(FIFO_MEM_2[30]), .A2(n72), .B1(FIFO_MEM_1[30]), .B2(n14), 
        .Q(n16) );
  AOI22X1 U167 ( .A1(FIFO_MEM_4[30]), .A2(n73), .B1(FIFO_MEM_3[30]), .B2(n7), 
        .Q(n15) );
  NAND2XL U168 ( .A(n16), .B(n15), .Q(Data_out[30]) );
  AOI22X1 U169 ( .A1(FIFO_MEM_2[13]), .A2(n72), .B1(FIFO_MEM_1[13]), .B2(n71), 
        .Q(n18) );
  AOI22X1 U170 ( .A1(FIFO_MEM_4[13]), .A2(n73), .B1(FIFO_MEM_3[13]), .B2(n7), 
        .Q(n17) );
  NAND2XL U171 ( .A(n18), .B(n17), .Q(Data_out[13]) );
  AOI22X1 U172 ( .A1(FIFO_MEM_2[15]), .A2(n72), .B1(FIFO_MEM_1[15]), .B2(n71), 
        .Q(n20) );
  AOI22X1 U173 ( .A1(FIFO_MEM_4[15]), .A2(n73), .B1(FIFO_MEM_3[15]), .B2(n7), 
        .Q(n19) );
  NAND2XL U174 ( .A(n20), .B(n19), .Q(Data_out[15]) );
  AOI22X1 U175 ( .A1(FIFO_MEM_2[14]), .A2(n72), .B1(FIFO_MEM_1[14]), .B2(n71), 
        .Q(n22) );
  AOI22X1 U176 ( .A1(FIFO_MEM_4[14]), .A2(n73), .B1(FIFO_MEM_3[14]), .B2(n7), 
        .Q(n21) );
  NAND2XL U177 ( .A(n22), .B(n21), .Q(Data_out[14]) );
  AOI22X1 U178 ( .A1(FIFO_MEM_2[9]), .A2(n72), .B1(FIFO_MEM_1[9]), .B2(n71), 
        .Q(n24) );
  AOI22X1 U179 ( .A1(FIFO_MEM_4[9]), .A2(n73), .B1(FIFO_MEM_3[9]), .B2(n7), 
        .Q(n23) );
  NAND2XL U180 ( .A(n24), .B(n23), .Q(Data_out[9]) );
  AOI22X1 U181 ( .A1(FIFO_MEM_2[6]), .A2(n72), .B1(FIFO_MEM_1[6]), .B2(n71), 
        .Q(n26) );
  AOI22X1 U182 ( .A1(FIFO_MEM_4[6]), .A2(n73), .B1(FIFO_MEM_3[6]), .B2(n7), 
        .Q(n25) );
  NAND2XL U183 ( .A(n26), .B(n25), .Q(Data_out[6]) );
  AOI22X1 U184 ( .A1(FIFO_MEM_2[0]), .A2(n72), .B1(FIFO_MEM_1[0]), .B2(n71), 
        .Q(n28) );
  AOI22X1 U185 ( .A1(FIFO_MEM_4[0]), .A2(n73), .B1(FIFO_MEM_3[0]), .B2(n7), 
        .Q(n27) );
  NAND2XL U186 ( .A(n28), .B(n27), .Q(Data_out[0]) );
  AOI22X1 U187 ( .A1(FIFO_MEM_2[10]), .A2(n72), .B1(FIFO_MEM_1[10]), .B2(n71), 
        .Q(n30) );
  AOI22X1 U188 ( .A1(FIFO_MEM_4[10]), .A2(n73), .B1(FIFO_MEM_3[10]), .B2(n7), 
        .Q(n29) );
  NAND2XL U189 ( .A(n30), .B(n29), .Q(Data_out[10]) );
  AOI22X1 U190 ( .A1(FIFO_MEM_2[2]), .A2(n72), .B1(FIFO_MEM_1[2]), .B2(n71), 
        .Q(n32) );
  AOI22X1 U191 ( .A1(FIFO_MEM_4[2]), .A2(n73), .B1(FIFO_MEM_3[2]), .B2(n7), 
        .Q(n31) );
  NAND2XL U192 ( .A(n32), .B(n31), .Q(Data_out[2]) );
  AOI22X1 U193 ( .A1(FIFO_MEM_2[8]), .A2(n72), .B1(FIFO_MEM_1[8]), .B2(n71), 
        .Q(n34) );
  AOI22X1 U194 ( .A1(FIFO_MEM_4[8]), .A2(n73), .B1(FIFO_MEM_3[8]), .B2(n7), 
        .Q(n33) );
  NAND2XL U195 ( .A(n34), .B(n33), .Q(Data_out[8]) );
  AOI22X1 U196 ( .A1(FIFO_MEM_2[7]), .A2(n72), .B1(FIFO_MEM_1[7]), .B2(n71), 
        .Q(n36) );
  AOI22X1 U197 ( .A1(FIFO_MEM_4[7]), .A2(n73), .B1(FIFO_MEM_3[7]), .B2(n7), 
        .Q(n35) );
  NAND2XL U198 ( .A(n36), .B(n35), .Q(Data_out[7]) );
  AOI22X1 U199 ( .A1(FIFO_MEM_2[3]), .A2(n72), .B1(FIFO_MEM_1[3]), .B2(n71), 
        .Q(n38) );
  AOI22X1 U200 ( .A1(FIFO_MEM_4[3]), .A2(n73), .B1(FIFO_MEM_3[3]), .B2(n7), 
        .Q(n37) );
  NAND2XL U201 ( .A(n38), .B(n37), .Q(Data_out[3]) );
  AOI22X1 U202 ( .A1(FIFO_MEM_2[5]), .A2(n72), .B1(FIFO_MEM_1[5]), .B2(n71), 
        .Q(n40) );
  AOI22X1 U203 ( .A1(FIFO_MEM_4[5]), .A2(n73), .B1(FIFO_MEM_3[5]), .B2(n7), 
        .Q(n39) );
  NAND2XL U204 ( .A(n40), .B(n39), .Q(Data_out[5]) );
  AOI22X1 U205 ( .A1(FIFO_MEM_2[4]), .A2(n72), .B1(FIFO_MEM_1[4]), .B2(n71), 
        .Q(n42) );
  AOI22X1 U206 ( .A1(FIFO_MEM_4[4]), .A2(n73), .B1(FIFO_MEM_3[4]), .B2(n7), 
        .Q(n41) );
  NAND2XL U207 ( .A(n42), .B(n41), .Q(Data_out[4]) );
  AOI22X1 U208 ( .A1(FIFO_MEM_2[12]), .A2(n72), .B1(FIFO_MEM_1[12]), .B2(n71), 
        .Q(n44) );
  AOI22X1 U209 ( .A1(FIFO_MEM_4[12]), .A2(n73), .B1(FIFO_MEM_3[12]), .B2(n7), 
        .Q(n43) );
  NAND2XL U210 ( .A(n44), .B(n43), .Q(Data_out[12]) );
  AOI22X1 U211 ( .A1(FIFO_MEM_2[1]), .A2(n72), .B1(FIFO_MEM_1[1]), .B2(n71), 
        .Q(n46) );
  AOI22X1 U212 ( .A1(FIFO_MEM_4[1]), .A2(n73), .B1(FIFO_MEM_3[1]), .B2(n7), 
        .Q(n45) );
  NAND2XL U213 ( .A(n46), .B(n45), .Q(Data_out[1]) );
  AOI22X1 U214 ( .A1(FIFO_MEM_2[11]), .A2(n72), .B1(FIFO_MEM_1[11]), .B2(n71), 
        .Q(n48) );
  AOI22X1 U215 ( .A1(FIFO_MEM_4[11]), .A2(n73), .B1(FIFO_MEM_3[11]), .B2(n7), 
        .Q(n47) );
  NAND2XL U216 ( .A(n48), .B(n47), .Q(Data_out[11]) );
  AOI22X1 U217 ( .A1(FIFO_MEM_2[24]), .A2(n72), .B1(FIFO_MEM_1[24]), .B2(n71), 
        .Q(n50) );
  AOI22X1 U218 ( .A1(FIFO_MEM_4[24]), .A2(n73), .B1(FIFO_MEM_3[24]), .B2(n7), 
        .Q(n49) );
  NAND2XL U219 ( .A(n50), .B(n49), .Q(Data_out[24]) );
  AOI22X1 U220 ( .A1(FIFO_MEM_2[27]), .A2(n72), .B1(FIFO_MEM_1[27]), .B2(n71), 
        .Q(n52) );
  AOI22X1 U221 ( .A1(FIFO_MEM_4[27]), .A2(n73), .B1(FIFO_MEM_3[27]), .B2(n7), 
        .Q(n51) );
  NAND2XL U222 ( .A(n52), .B(n51), .Q(Data_out[27]) );
  AOI22X1 U223 ( .A1(FIFO_MEM_2[20]), .A2(n72), .B1(FIFO_MEM_1[20]), .B2(n71), 
        .Q(n54) );
  AOI22X1 U224 ( .A1(FIFO_MEM_4[20]), .A2(n73), .B1(FIFO_MEM_3[20]), .B2(n7), 
        .Q(n53) );
  NAND2XL U225 ( .A(n54), .B(n53), .Q(Data_out[20]) );
  AOI22X1 U226 ( .A1(FIFO_MEM_2[18]), .A2(n72), .B1(FIFO_MEM_1[18]), .B2(n71), 
        .Q(n56) );
  AOI22X1 U227 ( .A1(FIFO_MEM_4[18]), .A2(n73), .B1(FIFO_MEM_3[18]), .B2(n7), 
        .Q(n55) );
  NAND2XL U228 ( .A(n56), .B(n55), .Q(Data_out[18]) );
  AOI22X1 U229 ( .A1(FIFO_MEM_2[25]), .A2(n72), .B1(FIFO_MEM_1[25]), .B2(n71), 
        .Q(n58) );
  AOI22X1 U230 ( .A1(FIFO_MEM_4[25]), .A2(n73), .B1(FIFO_MEM_3[25]), .B2(n7), 
        .Q(n57) );
  NAND2XL U231 ( .A(n58), .B(n57), .Q(Data_out[25]) );
  AOI22X1 U232 ( .A1(FIFO_MEM_2[17]), .A2(n72), .B1(FIFO_MEM_1[17]), .B2(n71), 
        .Q(n60) );
  AOI22X1 U233 ( .A1(FIFO_MEM_4[17]), .A2(n73), .B1(FIFO_MEM_3[17]), .B2(n7), 
        .Q(n59) );
  NAND2XL U234 ( .A(n60), .B(n59), .Q(Data_out[17]) );
  AOI22X1 U235 ( .A1(FIFO_MEM_2[19]), .A2(n72), .B1(FIFO_MEM_1[19]), .B2(n71), 
        .Q(n62) );
  AOI22X1 U236 ( .A1(FIFO_MEM_4[19]), .A2(n73), .B1(FIFO_MEM_3[19]), .B2(n7), 
        .Q(n61) );
  NAND2XL U237 ( .A(n62), .B(n61), .Q(Data_out[19]) );
  AOI22X1 U238 ( .A1(FIFO_MEM_2[22]), .A2(n72), .B1(FIFO_MEM_1[22]), .B2(n71), 
        .Q(n64) );
  AOI22X1 U239 ( .A1(FIFO_MEM_4[22]), .A2(n73), .B1(FIFO_MEM_3[22]), .B2(n7), 
        .Q(n63) );
  NAND2XL U240 ( .A(n64), .B(n63), .Q(Data_out[22]) );
  AOI22X1 U241 ( .A1(FIFO_MEM_2[21]), .A2(n72), .B1(FIFO_MEM_1[21]), .B2(n71), 
        .Q(n66) );
  AOI22X1 U242 ( .A1(FIFO_MEM_4[21]), .A2(n73), .B1(FIFO_MEM_3[21]), .B2(n7), 
        .Q(n65) );
  NAND2XL U243 ( .A(n66), .B(n65), .Q(Data_out[21]) );
  AOI22X1 U244 ( .A1(FIFO_MEM_2[26]), .A2(n72), .B1(FIFO_MEM_1[26]), .B2(n71), 
        .Q(n68) );
  AOI22X1 U245 ( .A1(FIFO_MEM_4[26]), .A2(n73), .B1(FIFO_MEM_3[26]), .B2(n7), 
        .Q(n67) );
  NAND2XL U246 ( .A(n68), .B(n67), .Q(Data_out[26]) );
  AOI22X1 U247 ( .A1(FIFO_MEM_2[28]), .A2(n72), .B1(FIFO_MEM_1[28]), .B2(n71), 
        .Q(n70) );
  AOI22X1 U248 ( .A1(FIFO_MEM_4[28]), .A2(n73), .B1(FIFO_MEM_3[28]), .B2(n7), 
        .Q(n69) );
  NAND2XL U249 ( .A(n70), .B(n69), .Q(Data_out[28]) );
  AOI22X1 U250 ( .A1(FIFO_MEM_2[23]), .A2(n72), .B1(FIFO_MEM_1[23]), .B2(n71), 
        .Q(n75) );
  AOI22X1 U251 ( .A1(FIFO_MEM_4[23]), .A2(n73), .B1(FIFO_MEM_3[23]), .B2(n7), 
        .Q(n74) );
  NAND2XL U252 ( .A(n75), .B(n74), .Q(Data_out[23]) );
  AOI22X1 U253 ( .A1(n103), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .Q(n76) );
  OAI221X1 U254 ( .A1(n103), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .C1(n76), .Q(n77) );
  AO21X1 U255 ( .A1(write_pointer[1]), .A2(n94), .B1(n83), .Q(
        write_pointer_in[1]) );
  NOR2XL U256 ( .A(write_pointer[2]), .B(write_pointer[1]), .Q(n84) );
  NAND3X1 U257 ( .A(write_pointer[3]), .B(n84), .C(n103), .Q(n80) );
  NOR2XL U258 ( .A(write_pointer[3]), .B(write_pointer[0]), .Q(n87) );
  NAND3X1 U259 ( .A(n102), .B(write_pointer[1]), .C(n87), .Q(n86) );
  NAND3X1 U260 ( .A(write_pointer[2]), .B(n87), .C(n99), .Q(n88) );
  AOI22X1 U261 ( .A1(read_en), .A2(n101), .B1(n100), .B2(n93), .Q(
        read_pointer_in[1]) );
  AOI22X1 U262 ( .A1(read_en), .A2(n100), .B1(n97), .B2(n93), .Q(
        read_pointer_in[2]) );
  AOI22X1 U263 ( .A1(read_en), .A2(n97), .B1(n98), .B2(n93), .Q(
        read_pointer_in[3]) );
  INVXL U264 ( .A(n94), .Q(n95) );
  AOI22X1 U265 ( .A1(n95), .A2(n96), .B1(n103), .B2(n94), .Q(
        write_pointer_in[0]) );
  AOI22X1 U266 ( .A1(n95), .A2(n99), .B1(n102), .B2(n94), .Q(
        write_pointer_in[2]) );
  AOI22X1 U267 ( .A1(n95), .A2(n102), .B1(n96), .B2(n94), .Q(
        write_pointer_in[3]) );
endmodule


module FIFO_credit_based_DATA_WIDTH32_3 ( reset, clk, RX, valid_in, read_en_N, 
        read_en_E, read_en_W, read_en_S, read_en_L, credit_out, empty_out, 
        Data_out );
  input [31:0] RX;
  output [31:0] Data_out;
  input reset, clk, valid_in, read_en_N, read_en_E, read_en_W, read_en_S,
         read_en_L;
  output credit_out, empty_out;
  wire   read_en, N68, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152, n153, n154, n155, n156, n157, n158, n159, n160, n161,
         n162, n163, n164, n165, n166, n167, n168, n169, n170, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n181, n182, n183,
         n184, n185, n186, n187, n188, n189, n190, n191, n192, n193, n194,
         n195, n196, n197, n198, n199, n200, n201, n202, n203, n204, n205,
         n206, n207, n208, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n225, n226, n227,
         n228, n229, n230, n231, n232, n233, n234, n235, n236, n1, n2, n3, n4,
         n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103;
  wire   [3:0] read_pointer;
  wire   [3:0] write_pointer;
  wire   [31:0] FIFO_MEM_1;
  wire   [31:0] FIFO_MEM_2;
  wire   [31:0] FIFO_MEM_3;
  wire   [31:0] FIFO_MEM_4;
  wire   [3:0] write_pointer_in;
  wire   [3:0] read_pointer_in;
  assign N68 = read_en_N;

  DFPX1 \write_pointer_reg[0]  ( .D(write_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(write_pointer[0]), .QN(n103) );
  DFCX1 \write_pointer_reg[1]  ( .D(write_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(write_pointer[1]), .QN(n99) );
  DFCX1 \write_pointer_reg[2]  ( .D(write_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(write_pointer[2]), .QN(n101) );
  DFCX1 \write_pointer_reg[3]  ( .D(write_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(write_pointer[3]), .QN(n96) );
  DFCX1 \read_pointer_reg[3]  ( .D(read_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(read_pointer[3]), .QN(n98) );
  DFCX1 \read_pointer_reg[1]  ( .D(read_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(read_pointer[1]), .QN(n100) );
  DFCX1 \read_pointer_reg[2]  ( .D(read_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(read_pointer[2]), .QN(n97) );
  DFCX1 \FIFO_MEM_1_reg[31]  ( .D(n109), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[31]) );
  DFCX1 \FIFO_MEM_1_reg[30]  ( .D(n110), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[30]) );
  DFCX1 \FIFO_MEM_1_reg[29]  ( .D(n111), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[29]) );
  DFCX1 \FIFO_MEM_1_reg[28]  ( .D(n112), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[28]) );
  DFCX1 \FIFO_MEM_1_reg[27]  ( .D(n113), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[27]) );
  DFCX1 \FIFO_MEM_1_reg[26]  ( .D(n114), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[26]) );
  DFCX1 \FIFO_MEM_1_reg[25]  ( .D(n115), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[25]) );
  DFCX1 \FIFO_MEM_1_reg[24]  ( .D(n116), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[24]) );
  DFCX1 \FIFO_MEM_1_reg[23]  ( .D(n117), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[23]) );
  DFCX1 \FIFO_MEM_1_reg[22]  ( .D(n118), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[22]) );
  DFCX1 \FIFO_MEM_1_reg[21]  ( .D(n119), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[21]) );
  DFCX1 \FIFO_MEM_1_reg[20]  ( .D(n120), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[20]) );
  DFCX1 \FIFO_MEM_1_reg[19]  ( .D(n121), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[19]) );
  DFCX1 \FIFO_MEM_1_reg[18]  ( .D(n122), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[18]) );
  DFCX1 \FIFO_MEM_1_reg[17]  ( .D(n123), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[17]) );
  DFCX1 \FIFO_MEM_1_reg[16]  ( .D(n124), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[16]) );
  DFCX1 \FIFO_MEM_1_reg[15]  ( .D(n125), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[15]) );
  DFCX1 \FIFO_MEM_1_reg[14]  ( .D(n126), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[14]) );
  DFCX1 \FIFO_MEM_1_reg[13]  ( .D(n127), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[13]) );
  DFCX1 \FIFO_MEM_1_reg[12]  ( .D(n128), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[12]) );
  DFCX1 \FIFO_MEM_1_reg[11]  ( .D(n129), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[11]) );
  DFCX1 \FIFO_MEM_1_reg[10]  ( .D(n130), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[10]) );
  DFCX1 \FIFO_MEM_1_reg[9]  ( .D(n131), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[9]) );
  DFCX1 \FIFO_MEM_1_reg[8]  ( .D(n132), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[8]) );
  DFCX1 \FIFO_MEM_1_reg[7]  ( .D(n133), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[7]) );
  DFCX1 \FIFO_MEM_1_reg[6]  ( .D(n134), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[6]) );
  DFCX1 \FIFO_MEM_1_reg[5]  ( .D(n135), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[5]) );
  DFCX1 \FIFO_MEM_1_reg[4]  ( .D(n136), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[4]) );
  DFCX1 \FIFO_MEM_1_reg[3]  ( .D(n137), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[3]) );
  DFCX1 \FIFO_MEM_1_reg[2]  ( .D(n138), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[2]) );
  DFCX1 \FIFO_MEM_1_reg[1]  ( .D(n139), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[1]) );
  DFCX1 \FIFO_MEM_1_reg[0]  ( .D(n140), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[0]) );
  DFCX1 \FIFO_MEM_2_reg[31]  ( .D(n141), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[31]) );
  DFCX1 \FIFO_MEM_2_reg[30]  ( .D(n142), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[30]) );
  DFCX1 \FIFO_MEM_2_reg[29]  ( .D(n143), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[29]) );
  DFCX1 \FIFO_MEM_2_reg[28]  ( .D(n144), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[28]) );
  DFCX1 \FIFO_MEM_2_reg[27]  ( .D(n145), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[27]) );
  DFCX1 \FIFO_MEM_2_reg[26]  ( .D(n146), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[26]) );
  DFCX1 \FIFO_MEM_2_reg[25]  ( .D(n147), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[25]) );
  DFCX1 \FIFO_MEM_2_reg[24]  ( .D(n148), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[24]) );
  DFCX1 \FIFO_MEM_2_reg[23]  ( .D(n149), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[23]) );
  DFCX1 \FIFO_MEM_2_reg[22]  ( .D(n150), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[22]) );
  DFCX1 \FIFO_MEM_2_reg[21]  ( .D(n151), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[21]) );
  DFCX1 \FIFO_MEM_2_reg[20]  ( .D(n152), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[20]) );
  DFCX1 \FIFO_MEM_2_reg[19]  ( .D(n153), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[19]) );
  DFCX1 \FIFO_MEM_2_reg[18]  ( .D(n154), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[18]) );
  DFCX1 \FIFO_MEM_2_reg[17]  ( .D(n155), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[17]) );
  DFCX1 \FIFO_MEM_2_reg[16]  ( .D(n156), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[16]) );
  DFCX1 \FIFO_MEM_2_reg[15]  ( .D(n157), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[15]) );
  DFCX1 \FIFO_MEM_2_reg[14]  ( .D(n158), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[14]) );
  DFCX1 \FIFO_MEM_2_reg[13]  ( .D(n159), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[13]) );
  DFCX1 \FIFO_MEM_2_reg[12]  ( .D(n160), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[12]) );
  DFCX1 \FIFO_MEM_2_reg[11]  ( .D(n161), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[11]) );
  DFCX1 \FIFO_MEM_2_reg[10]  ( .D(n162), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[10]) );
  DFCX1 \FIFO_MEM_2_reg[9]  ( .D(n163), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[9]) );
  DFCX1 \FIFO_MEM_2_reg[8]  ( .D(n164), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[8]) );
  DFCX1 \FIFO_MEM_2_reg[7]  ( .D(n165), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[7]) );
  DFCX1 \FIFO_MEM_2_reg[6]  ( .D(n166), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[6]) );
  DFCX1 \FIFO_MEM_2_reg[5]  ( .D(n167), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[5]) );
  DFCX1 \FIFO_MEM_2_reg[4]  ( .D(n168), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[4]) );
  DFCX1 \FIFO_MEM_2_reg[3]  ( .D(n169), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[3]) );
  DFCX1 \FIFO_MEM_2_reg[2]  ( .D(n170), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[2]) );
  DFCX1 \FIFO_MEM_2_reg[1]  ( .D(n171), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[1]) );
  DFCX1 \FIFO_MEM_2_reg[0]  ( .D(n172), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[0]) );
  DFCX1 \FIFO_MEM_3_reg[31]  ( .D(n173), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[31]) );
  DFCX1 \FIFO_MEM_3_reg[30]  ( .D(n174), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[30]) );
  DFCX1 \FIFO_MEM_3_reg[29]  ( .D(n175), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[29]) );
  DFCX1 \FIFO_MEM_3_reg[28]  ( .D(n176), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[28]) );
  DFCX1 \FIFO_MEM_3_reg[27]  ( .D(n177), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[27]) );
  DFCX1 \FIFO_MEM_3_reg[26]  ( .D(n178), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[26]) );
  DFCX1 \FIFO_MEM_3_reg[25]  ( .D(n179), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[25]) );
  DFCX1 \FIFO_MEM_3_reg[24]  ( .D(n180), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[24]) );
  DFCX1 \FIFO_MEM_3_reg[23]  ( .D(n181), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[23]) );
  DFCX1 \FIFO_MEM_3_reg[22]  ( .D(n182), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[22]) );
  DFCX1 \FIFO_MEM_3_reg[21]  ( .D(n183), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[21]) );
  DFCX1 \FIFO_MEM_3_reg[20]  ( .D(n184), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[20]) );
  DFCX1 \FIFO_MEM_3_reg[19]  ( .D(n185), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[19]) );
  DFCX1 \FIFO_MEM_3_reg[18]  ( .D(n186), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[18]) );
  DFCX1 \FIFO_MEM_3_reg[17]  ( .D(n187), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[17]) );
  DFCX1 \FIFO_MEM_3_reg[16]  ( .D(n188), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[16]) );
  DFCX1 \FIFO_MEM_3_reg[15]  ( .D(n189), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[15]) );
  DFCX1 \FIFO_MEM_3_reg[14]  ( .D(n190), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[14]) );
  DFCX1 \FIFO_MEM_3_reg[13]  ( .D(n191), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[13]) );
  DFCX1 \FIFO_MEM_3_reg[12]  ( .D(n192), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[12]) );
  DFCX1 \FIFO_MEM_3_reg[11]  ( .D(n193), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[11]) );
  DFCX1 \FIFO_MEM_3_reg[10]  ( .D(n194), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[10]) );
  DFCX1 \FIFO_MEM_3_reg[9]  ( .D(n195), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[9]) );
  DFCX1 \FIFO_MEM_3_reg[8]  ( .D(n196), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[8]) );
  DFCX1 \FIFO_MEM_3_reg[7]  ( .D(n197), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[7]) );
  DFCX1 \FIFO_MEM_3_reg[6]  ( .D(n198), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[6]) );
  DFCX1 \FIFO_MEM_3_reg[5]  ( .D(n199), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[5]) );
  DFCX1 \FIFO_MEM_3_reg[4]  ( .D(n200), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[4]) );
  DFCX1 \FIFO_MEM_3_reg[3]  ( .D(n201), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[3]) );
  DFCX1 \FIFO_MEM_3_reg[2]  ( .D(n202), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[2]) );
  DFCX1 \FIFO_MEM_3_reg[1]  ( .D(n203), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[1]) );
  DFCX1 \FIFO_MEM_3_reg[0]  ( .D(n204), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[0]) );
  DFCX1 \FIFO_MEM_4_reg[31]  ( .D(n205), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[31]) );
  DFCX1 \FIFO_MEM_4_reg[30]  ( .D(n206), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[30]) );
  DFCX1 \FIFO_MEM_4_reg[29]  ( .D(n207), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[29]) );
  DFCX1 \FIFO_MEM_4_reg[28]  ( .D(n208), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[28]) );
  DFCX1 \FIFO_MEM_4_reg[27]  ( .D(n209), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[27]) );
  DFCX1 \FIFO_MEM_4_reg[26]  ( .D(n210), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[26]) );
  DFCX1 \FIFO_MEM_4_reg[25]  ( .D(n211), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[25]) );
  DFCX1 \FIFO_MEM_4_reg[24]  ( .D(n212), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[24]) );
  DFCX1 \FIFO_MEM_4_reg[23]  ( .D(n213), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[23]) );
  DFCX1 \FIFO_MEM_4_reg[22]  ( .D(n214), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[22]) );
  DFCX1 \FIFO_MEM_4_reg[21]  ( .D(n215), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[21]) );
  DFCX1 \FIFO_MEM_4_reg[20]  ( .D(n216), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[20]) );
  DFCX1 \FIFO_MEM_4_reg[19]  ( .D(n217), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[19]) );
  DFCX1 \FIFO_MEM_4_reg[18]  ( .D(n218), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[18]) );
  DFCX1 \FIFO_MEM_4_reg[17]  ( .D(n219), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[17]) );
  DFCX1 \FIFO_MEM_4_reg[16]  ( .D(n220), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[16]) );
  DFCX1 \FIFO_MEM_4_reg[15]  ( .D(n221), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[15]) );
  DFCX1 \FIFO_MEM_4_reg[14]  ( .D(n222), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[14]) );
  DFCX1 \FIFO_MEM_4_reg[13]  ( .D(n223), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[13]) );
  DFCX1 \FIFO_MEM_4_reg[12]  ( .D(n224), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[12]) );
  DFCX1 \FIFO_MEM_4_reg[11]  ( .D(n225), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[11]) );
  DFCX1 \FIFO_MEM_4_reg[10]  ( .D(n226), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[10]) );
  DFCX1 \FIFO_MEM_4_reg[9]  ( .D(n227), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[9]) );
  DFCX1 \FIFO_MEM_4_reg[8]  ( .D(n228), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[8]) );
  DFCX1 \FIFO_MEM_4_reg[7]  ( .D(n229), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[7]) );
  DFCX1 \FIFO_MEM_4_reg[6]  ( .D(n230), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[6]) );
  DFCX1 \FIFO_MEM_4_reg[5]  ( .D(n231), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[5]) );
  DFCX1 \FIFO_MEM_4_reg[4]  ( .D(n232), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[4]) );
  DFCX1 \FIFO_MEM_4_reg[3]  ( .D(n233), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[3]) );
  DFCX1 \FIFO_MEM_4_reg[2]  ( .D(n234), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[2]) );
  DFCX1 \FIFO_MEM_4_reg[1]  ( .D(n235), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[1]) );
  DFCX1 \FIFO_MEM_4_reg[0]  ( .D(n236), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[0]) );
  DFCX1 credit_out_reg ( .D(read_en), .CP(clk), .RN(reset), .Q(credit_out) );
  DFPX1 \read_pointer_reg[0]  ( .D(read_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(read_pointer[0]), .QN(n102) );
  NAND2XL U3 ( .A(n8), .B(n7), .Q(Data_out[31]) );
  NAND2X3 U4 ( .A(valid_in), .B(n79), .Q(n94) );
  OAI221X2 U5 ( .A1(write_pointer[2]), .A2(n98), .B1(n101), .B2(
        read_pointer[3]), .C1(n78), .Q(n79) );
  AOI221X2 U6 ( .A1(write_pointer[1]), .A2(n97), .B1(n99), .B2(read_pointer[2]), .C1(n77), .Q(n78) );
  INVXL U7 ( .A(read_en), .Q(n93) );
  NOR2X3 U8 ( .A(empty_out), .B(n5), .Q(read_en) );
  CLKINVX2 U9 ( .A(n85), .Q(n1) );
  NAND2X2 U10 ( .A(n14), .B(n13), .Q(Data_out[29]) );
  NAND2X2 U11 ( .A(n10), .B(n9), .Q(Data_out[30]) );
  AOI22X2 U12 ( .A1(FIFO_MEM_2[30]), .A2(n71), .B1(FIFO_MEM_1[30]), .B2(n43), 
        .Q(n10) );
  AOI221X2 U13 ( .A1(write_pointer[3]), .A2(n98), .B1(n96), .B2(
        read_pointer[3]), .C1(n4), .Q(empty_out) );
  NAND2X2 U14 ( .A(n102), .B(n100), .Q(n6) );
  NAND2XL U15 ( .A(n12), .B(n11), .Q(Data_out[14]) );
  NOR2X3 U16 ( .A(n94), .B(n80), .Q(n82) );
  NOR2X3 U17 ( .A(n88), .B(n94), .Q(n90) );
  NOR2X3 U18 ( .A(n86), .B(n94), .Q(n92) );
  NOR2XL U19 ( .A(n103), .B(n94), .Q(n83) );
  AOI221X1 U20 ( .A1(n99), .A2(read_pointer[1]), .B1(write_pointer[0]), .B2(
        n102), .C1(n2), .Q(n3) );
  CLKINVX2 U21 ( .A(n82), .Q(n81) );
  CLKINVX2 U22 ( .A(n90), .Q(n89) );
  CLKINVX2 U23 ( .A(n92), .Q(n91) );
  NOR4X1 U24 ( .A(N68), .B(read_en_W), .C(read_en_S), .D(read_en_L), .Q(n5) );
  AO22X1 U25 ( .A1(n82), .A2(RX[0]), .B1(FIFO_MEM_4[0]), .B2(n81), .Q(n236) );
  AO22X1 U26 ( .A1(RX[1]), .A2(n82), .B1(FIFO_MEM_4[1]), .B2(n81), .Q(n235) );
  AO22X1 U27 ( .A1(RX[2]), .A2(n82), .B1(FIFO_MEM_4[2]), .B2(n81), .Q(n234) );
  AO22X1 U28 ( .A1(RX[3]), .A2(n82), .B1(FIFO_MEM_4[3]), .B2(n81), .Q(n233) );
  AO22X1 U29 ( .A1(RX[4]), .A2(n82), .B1(FIFO_MEM_4[4]), .B2(n81), .Q(n232) );
  AO22X1 U30 ( .A1(RX[5]), .A2(n82), .B1(FIFO_MEM_4[5]), .B2(n81), .Q(n231) );
  AO22X1 U31 ( .A1(RX[6]), .A2(n82), .B1(FIFO_MEM_4[6]), .B2(n81), .Q(n230) );
  AO22X1 U32 ( .A1(RX[7]), .A2(n82), .B1(FIFO_MEM_4[7]), .B2(n81), .Q(n229) );
  AO22X1 U33 ( .A1(RX[8]), .A2(n82), .B1(FIFO_MEM_4[8]), .B2(n81), .Q(n228) );
  AO22X1 U34 ( .A1(RX[9]), .A2(n82), .B1(FIFO_MEM_4[9]), .B2(n81), .Q(n227) );
  AO22X1 U35 ( .A1(RX[10]), .A2(n82), .B1(FIFO_MEM_4[10]), .B2(n81), .Q(n226)
         );
  AO22X1 U36 ( .A1(RX[11]), .A2(n82), .B1(FIFO_MEM_4[11]), .B2(n81), .Q(n225)
         );
  AO22X1 U37 ( .A1(RX[12]), .A2(n82), .B1(FIFO_MEM_4[12]), .B2(n81), .Q(n224)
         );
  AO22X1 U38 ( .A1(RX[13]), .A2(n82), .B1(FIFO_MEM_4[13]), .B2(n81), .Q(n223)
         );
  AO22X1 U39 ( .A1(RX[14]), .A2(n82), .B1(FIFO_MEM_4[14]), .B2(n81), .Q(n222)
         );
  AO22X1 U40 ( .A1(RX[15]), .A2(n82), .B1(FIFO_MEM_4[15]), .B2(n81), .Q(n221)
         );
  AO22X1 U41 ( .A1(RX[16]), .A2(n82), .B1(FIFO_MEM_4[16]), .B2(n81), .Q(n220)
         );
  AO22X1 U42 ( .A1(RX[17]), .A2(n82), .B1(FIFO_MEM_4[17]), .B2(n81), .Q(n219)
         );
  AO22X1 U43 ( .A1(RX[18]), .A2(n82), .B1(FIFO_MEM_4[18]), .B2(n81), .Q(n218)
         );
  AO22X1 U44 ( .A1(RX[19]), .A2(n82), .B1(FIFO_MEM_4[19]), .B2(n81), .Q(n217)
         );
  AO22X1 U45 ( .A1(RX[20]), .A2(n82), .B1(FIFO_MEM_4[20]), .B2(n81), .Q(n216)
         );
  AO22X1 U46 ( .A1(RX[21]), .A2(n82), .B1(FIFO_MEM_4[21]), .B2(n81), .Q(n215)
         );
  AO22X1 U47 ( .A1(RX[22]), .A2(n82), .B1(FIFO_MEM_4[22]), .B2(n81), .Q(n214)
         );
  AO22X1 U48 ( .A1(RX[23]), .A2(n82), .B1(FIFO_MEM_4[23]), .B2(n81), .Q(n213)
         );
  AO22X1 U49 ( .A1(RX[24]), .A2(n82), .B1(FIFO_MEM_4[24]), .B2(n81), .Q(n212)
         );
  AO22X1 U50 ( .A1(RX[25]), .A2(n82), .B1(FIFO_MEM_4[25]), .B2(n81), .Q(n211)
         );
  AO22X1 U51 ( .A1(RX[26]), .A2(n82), .B1(FIFO_MEM_4[26]), .B2(n81), .Q(n210)
         );
  AO22X1 U52 ( .A1(RX[27]), .A2(n82), .B1(FIFO_MEM_4[27]), .B2(n81), .Q(n209)
         );
  AO22X1 U53 ( .A1(RX[28]), .A2(n82), .B1(FIFO_MEM_4[28]), .B2(n81), .Q(n208)
         );
  AO22X1 U54 ( .A1(RX[29]), .A2(n82), .B1(FIFO_MEM_4[29]), .B2(n81), .Q(n207)
         );
  AO22X1 U55 ( .A1(RX[30]), .A2(n82), .B1(FIFO_MEM_4[30]), .B2(n81), .Q(n206)
         );
  AO22X1 U56 ( .A1(RX[31]), .A2(n82), .B1(FIFO_MEM_4[31]), .B2(n81), .Q(n205)
         );
  AO22X1 U57 ( .A1(RX[0]), .A2(n90), .B1(FIFO_MEM_3[0]), .B2(n89), .Q(n204) );
  AO22X1 U58 ( .A1(RX[1]), .A2(n90), .B1(FIFO_MEM_3[1]), .B2(n89), .Q(n203) );
  AO22X1 U59 ( .A1(RX[2]), .A2(n90), .B1(FIFO_MEM_3[2]), .B2(n89), .Q(n202) );
  AO22X1 U60 ( .A1(RX[3]), .A2(n90), .B1(FIFO_MEM_3[3]), .B2(n89), .Q(n201) );
  AO22X1 U61 ( .A1(RX[4]), .A2(n90), .B1(FIFO_MEM_3[4]), .B2(n89), .Q(n200) );
  AO22X1 U62 ( .A1(RX[5]), .A2(n90), .B1(FIFO_MEM_3[5]), .B2(n89), .Q(n199) );
  AO22X1 U63 ( .A1(RX[6]), .A2(n90), .B1(FIFO_MEM_3[6]), .B2(n89), .Q(n198) );
  AO22X1 U64 ( .A1(RX[7]), .A2(n90), .B1(FIFO_MEM_3[7]), .B2(n89), .Q(n197) );
  AO22X1 U65 ( .A1(RX[8]), .A2(n90), .B1(FIFO_MEM_3[8]), .B2(n89), .Q(n196) );
  AO22X1 U66 ( .A1(RX[9]), .A2(n90), .B1(FIFO_MEM_3[9]), .B2(n89), .Q(n195) );
  AO22X1 U67 ( .A1(RX[10]), .A2(n90), .B1(FIFO_MEM_3[10]), .B2(n89), .Q(n194)
         );
  AO22X1 U68 ( .A1(RX[11]), .A2(n90), .B1(FIFO_MEM_3[11]), .B2(n89), .Q(n193)
         );
  AO22X1 U69 ( .A1(RX[12]), .A2(n90), .B1(FIFO_MEM_3[12]), .B2(n89), .Q(n192)
         );
  AO22X1 U70 ( .A1(RX[13]), .A2(n90), .B1(FIFO_MEM_3[13]), .B2(n89), .Q(n191)
         );
  AO22X1 U71 ( .A1(RX[14]), .A2(n90), .B1(FIFO_MEM_3[14]), .B2(n89), .Q(n190)
         );
  AO22X1 U72 ( .A1(RX[15]), .A2(n90), .B1(FIFO_MEM_3[15]), .B2(n89), .Q(n189)
         );
  AO22X1 U73 ( .A1(RX[16]), .A2(n90), .B1(FIFO_MEM_3[16]), .B2(n89), .Q(n188)
         );
  AO22X1 U74 ( .A1(RX[17]), .A2(n90), .B1(FIFO_MEM_3[17]), .B2(n89), .Q(n187)
         );
  AO22X1 U75 ( .A1(RX[18]), .A2(n90), .B1(FIFO_MEM_3[18]), .B2(n89), .Q(n186)
         );
  AO22X1 U76 ( .A1(RX[19]), .A2(n90), .B1(FIFO_MEM_3[19]), .B2(n89), .Q(n185)
         );
  AO22X1 U77 ( .A1(RX[20]), .A2(n90), .B1(FIFO_MEM_3[20]), .B2(n89), .Q(n184)
         );
  AO22X1 U78 ( .A1(RX[21]), .A2(n90), .B1(FIFO_MEM_3[21]), .B2(n89), .Q(n183)
         );
  AO22X1 U79 ( .A1(RX[22]), .A2(n90), .B1(FIFO_MEM_3[22]), .B2(n89), .Q(n182)
         );
  AO22X1 U80 ( .A1(RX[23]), .A2(n90), .B1(FIFO_MEM_3[23]), .B2(n89), .Q(n181)
         );
  AO22X1 U81 ( .A1(RX[24]), .A2(n90), .B1(FIFO_MEM_3[24]), .B2(n89), .Q(n180)
         );
  AO22X1 U82 ( .A1(RX[25]), .A2(n90), .B1(FIFO_MEM_3[25]), .B2(n89), .Q(n179)
         );
  AO22X1 U83 ( .A1(RX[26]), .A2(n90), .B1(FIFO_MEM_3[26]), .B2(n89), .Q(n178)
         );
  AO22X1 U84 ( .A1(RX[27]), .A2(n90), .B1(FIFO_MEM_3[27]), .B2(n89), .Q(n177)
         );
  AO22X1 U85 ( .A1(RX[28]), .A2(n90), .B1(FIFO_MEM_3[28]), .B2(n89), .Q(n176)
         );
  AO22X1 U86 ( .A1(RX[29]), .A2(n90), .B1(FIFO_MEM_3[29]), .B2(n89), .Q(n175)
         );
  AO22X1 U87 ( .A1(RX[30]), .A2(n90), .B1(FIFO_MEM_3[30]), .B2(n89), .Q(n174)
         );
  AO22X1 U88 ( .A1(RX[31]), .A2(n90), .B1(FIFO_MEM_3[31]), .B2(n89), .Q(n173)
         );
  AO22X1 U89 ( .A1(RX[0]), .A2(n92), .B1(FIFO_MEM_2[0]), .B2(n91), .Q(n172) );
  AO22X1 U90 ( .A1(RX[1]), .A2(n92), .B1(FIFO_MEM_2[1]), .B2(n91), .Q(n171) );
  AO22X1 U91 ( .A1(RX[2]), .A2(n92), .B1(FIFO_MEM_2[2]), .B2(n91), .Q(n170) );
  AO22X1 U92 ( .A1(RX[3]), .A2(n92), .B1(FIFO_MEM_2[3]), .B2(n91), .Q(n169) );
  AO22X1 U93 ( .A1(RX[4]), .A2(n92), .B1(FIFO_MEM_2[4]), .B2(n91), .Q(n168) );
  AO22X1 U94 ( .A1(RX[5]), .A2(n92), .B1(FIFO_MEM_2[5]), .B2(n91), .Q(n167) );
  AO22X1 U95 ( .A1(RX[6]), .A2(n92), .B1(FIFO_MEM_2[6]), .B2(n91), .Q(n166) );
  AO22X1 U96 ( .A1(RX[7]), .A2(n92), .B1(FIFO_MEM_2[7]), .B2(n91), .Q(n165) );
  AO22X1 U97 ( .A1(RX[8]), .A2(n92), .B1(FIFO_MEM_2[8]), .B2(n91), .Q(n164) );
  AO22X1 U98 ( .A1(RX[9]), .A2(n92), .B1(FIFO_MEM_2[9]), .B2(n91), .Q(n163) );
  AO22X1 U99 ( .A1(RX[10]), .A2(n92), .B1(FIFO_MEM_2[10]), .B2(n91), .Q(n162)
         );
  AO22X1 U100 ( .A1(RX[11]), .A2(n92), .B1(FIFO_MEM_2[11]), .B2(n91), .Q(n161)
         );
  AO22X1 U101 ( .A1(RX[12]), .A2(n92), .B1(FIFO_MEM_2[12]), .B2(n91), .Q(n160)
         );
  AO22X1 U102 ( .A1(RX[13]), .A2(n92), .B1(FIFO_MEM_2[13]), .B2(n91), .Q(n159)
         );
  AO22X1 U103 ( .A1(RX[14]), .A2(n92), .B1(FIFO_MEM_2[14]), .B2(n91), .Q(n158)
         );
  AO22X1 U104 ( .A1(RX[15]), .A2(n92), .B1(FIFO_MEM_2[15]), .B2(n91), .Q(n157)
         );
  AO22X1 U105 ( .A1(RX[16]), .A2(n92), .B1(FIFO_MEM_2[16]), .B2(n91), .Q(n156)
         );
  AO22X1 U106 ( .A1(RX[17]), .A2(n92), .B1(FIFO_MEM_2[17]), .B2(n91), .Q(n155)
         );
  AO22X1 U107 ( .A1(RX[18]), .A2(n92), .B1(FIFO_MEM_2[18]), .B2(n91), .Q(n154)
         );
  AO22X1 U108 ( .A1(RX[19]), .A2(n92), .B1(FIFO_MEM_2[19]), .B2(n91), .Q(n153)
         );
  AO22X1 U109 ( .A1(RX[20]), .A2(n92), .B1(FIFO_MEM_2[20]), .B2(n91), .Q(n152)
         );
  AO22X1 U110 ( .A1(RX[21]), .A2(n92), .B1(FIFO_MEM_2[21]), .B2(n91), .Q(n151)
         );
  AO22X1 U111 ( .A1(RX[22]), .A2(n92), .B1(FIFO_MEM_2[22]), .B2(n91), .Q(n150)
         );
  AO22X1 U112 ( .A1(RX[23]), .A2(n92), .B1(FIFO_MEM_2[23]), .B2(n91), .Q(n149)
         );
  AO22X1 U113 ( .A1(RX[24]), .A2(n92), .B1(FIFO_MEM_2[24]), .B2(n91), .Q(n148)
         );
  AO22X1 U114 ( .A1(RX[25]), .A2(n92), .B1(FIFO_MEM_2[25]), .B2(n91), .Q(n147)
         );
  AO22X1 U115 ( .A1(RX[26]), .A2(n92), .B1(FIFO_MEM_2[26]), .B2(n91), .Q(n146)
         );
  AO22X1 U116 ( .A1(RX[27]), .A2(n92), .B1(FIFO_MEM_2[27]), .B2(n91), .Q(n145)
         );
  AO22X1 U117 ( .A1(RX[28]), .A2(n92), .B1(FIFO_MEM_2[28]), .B2(n91), .Q(n144)
         );
  AO22X1 U118 ( .A1(RX[29]), .A2(n92), .B1(FIFO_MEM_2[29]), .B2(n91), .Q(n143)
         );
  AO22X1 U119 ( .A1(RX[30]), .A2(n92), .B1(FIFO_MEM_2[30]), .B2(n91), .Q(n142)
         );
  AO22X1 U120 ( .A1(RX[31]), .A2(n92), .B1(FIFO_MEM_2[31]), .B2(n91), .Q(n141)
         );
  AO22X1 U121 ( .A1(n85), .A2(RX[0]), .B1(n1), .B2(FIFO_MEM_1[0]), .Q(n140) );
  AO22X1 U122 ( .A1(n85), .A2(RX[1]), .B1(n1), .B2(FIFO_MEM_1[1]), .Q(n139) );
  AO22X1 U123 ( .A1(n85), .A2(RX[2]), .B1(n1), .B2(FIFO_MEM_1[2]), .Q(n138) );
  AO22X1 U124 ( .A1(n85), .A2(RX[3]), .B1(n1), .B2(FIFO_MEM_1[3]), .Q(n137) );
  AO22X1 U125 ( .A1(n85), .A2(RX[4]), .B1(n1), .B2(FIFO_MEM_1[4]), .Q(n136) );
  AO22X1 U126 ( .A1(n85), .A2(RX[5]), .B1(n1), .B2(FIFO_MEM_1[5]), .Q(n135) );
  AO22X1 U127 ( .A1(n85), .A2(RX[6]), .B1(n1), .B2(FIFO_MEM_1[6]), .Q(n134) );
  AO22X1 U128 ( .A1(n85), .A2(RX[7]), .B1(n1), .B2(FIFO_MEM_1[7]), .Q(n133) );
  AO22X1 U129 ( .A1(n85), .A2(RX[8]), .B1(n1), .B2(FIFO_MEM_1[8]), .Q(n132) );
  AO22X1 U130 ( .A1(n85), .A2(RX[9]), .B1(n1), .B2(FIFO_MEM_1[9]), .Q(n131) );
  AO22X1 U131 ( .A1(n85), .A2(RX[10]), .B1(n1), .B2(FIFO_MEM_1[10]), .Q(n130)
         );
  AO22X1 U132 ( .A1(n85), .A2(RX[11]), .B1(n1), .B2(FIFO_MEM_1[11]), .Q(n129)
         );
  AO22X1 U133 ( .A1(n85), .A2(RX[12]), .B1(n1), .B2(FIFO_MEM_1[12]), .Q(n128)
         );
  AO22X1 U134 ( .A1(n85), .A2(RX[13]), .B1(n1), .B2(FIFO_MEM_1[13]), .Q(n127)
         );
  AO22X1 U135 ( .A1(n85), .A2(RX[14]), .B1(n1), .B2(FIFO_MEM_1[14]), .Q(n126)
         );
  AO22X1 U136 ( .A1(n85), .A2(RX[15]), .B1(n1), .B2(FIFO_MEM_1[15]), .Q(n125)
         );
  AO22X1 U137 ( .A1(n85), .A2(RX[16]), .B1(n1), .B2(FIFO_MEM_1[16]), .Q(n124)
         );
  AO22X1 U138 ( .A1(n85), .A2(RX[17]), .B1(n1), .B2(FIFO_MEM_1[17]), .Q(n123)
         );
  AO22X1 U139 ( .A1(n85), .A2(RX[18]), .B1(n1), .B2(FIFO_MEM_1[18]), .Q(n122)
         );
  AO22X1 U140 ( .A1(n85), .A2(RX[19]), .B1(n1), .B2(FIFO_MEM_1[19]), .Q(n121)
         );
  AO22X1 U141 ( .A1(n85), .A2(RX[20]), .B1(n1), .B2(FIFO_MEM_1[20]), .Q(n120)
         );
  AO22X1 U142 ( .A1(n85), .A2(RX[21]), .B1(n1), .B2(FIFO_MEM_1[21]), .Q(n119)
         );
  AO22X1 U143 ( .A1(n85), .A2(RX[22]), .B1(n1), .B2(FIFO_MEM_1[22]), .Q(n118)
         );
  AO22X1 U144 ( .A1(n85), .A2(RX[23]), .B1(n1), .B2(FIFO_MEM_1[23]), .Q(n117)
         );
  AO22X1 U145 ( .A1(n85), .A2(RX[24]), .B1(n1), .B2(FIFO_MEM_1[24]), .Q(n116)
         );
  AO22X1 U146 ( .A1(n85), .A2(RX[25]), .B1(n1), .B2(FIFO_MEM_1[25]), .Q(n115)
         );
  AO22X1 U147 ( .A1(n85), .A2(RX[26]), .B1(n1), .B2(FIFO_MEM_1[26]), .Q(n114)
         );
  AO22X1 U148 ( .A1(n85), .A2(RX[27]), .B1(n1), .B2(FIFO_MEM_1[27]), .Q(n113)
         );
  AO22X1 U149 ( .A1(n85), .A2(RX[28]), .B1(n1), .B2(FIFO_MEM_1[28]), .Q(n112)
         );
  AO22X1 U150 ( .A1(n85), .A2(RX[29]), .B1(n1), .B2(FIFO_MEM_1[29]), .Q(n111)
         );
  AO22X1 U151 ( .A1(n85), .A2(RX[30]), .B1(n1), .B2(FIFO_MEM_1[30]), .Q(n110)
         );
  AO22X1 U152 ( .A1(n85), .A2(RX[31]), .B1(n1), .B2(FIFO_MEM_1[31]), .Q(n109)
         );
  NOR3X3 U153 ( .A(n72), .B(n73), .C(n71), .Q(n43) );
  CLKBUFX2 U154 ( .A(n43), .Q(n70) );
  AND3X2 U155 ( .A(n84), .B(n83), .C(n96), .Q(n85) );
  AOI22X1 U156 ( .A1(FIFO_MEM_2[29]), .A2(n71), .B1(FIFO_MEM_1[29]), .B2(n70), 
        .Q(n14) );
  AOI22X1 U157 ( .A1(FIFO_MEM_2[31]), .A2(n71), .B1(FIFO_MEM_1[31]), .B2(n43), 
        .Q(n8) );
  OAI22X1 U158 ( .A1(n99), .A2(read_pointer[1]), .B1(n102), .B2(
        write_pointer[0]), .Q(n2) );
  OAI221X1 U159 ( .A1(write_pointer[2]), .A2(n97), .B1(n101), .B2(
        read_pointer[2]), .C1(n3), .Q(n4) );
  NOR4X6 U160 ( .A(read_pointer[0]), .B(read_pointer[3]), .C(read_pointer[2]), 
        .D(n100), .Q(n71) );
  NOR3X3 U161 ( .A(read_pointer[3]), .B(n97), .C(n6), .Q(n72) );
  NOR3X3 U162 ( .A(read_pointer[2]), .B(n98), .C(n6), .Q(n73) );
  AOI22X1 U163 ( .A1(FIFO_MEM_4[31]), .A2(n73), .B1(FIFO_MEM_3[31]), .B2(n72), 
        .Q(n7) );
  AOI22X1 U164 ( .A1(FIFO_MEM_4[30]), .A2(n73), .B1(FIFO_MEM_3[30]), .B2(n72), 
        .Q(n9) );
  AOI22X1 U165 ( .A1(FIFO_MEM_2[14]), .A2(n71), .B1(FIFO_MEM_1[14]), .B2(n70), 
        .Q(n12) );
  AOI22X1 U166 ( .A1(FIFO_MEM_4[14]), .A2(n73), .B1(FIFO_MEM_3[14]), .B2(n72), 
        .Q(n11) );
  AOI22X1 U167 ( .A1(FIFO_MEM_4[29]), .A2(n73), .B1(FIFO_MEM_3[29]), .B2(n72), 
        .Q(n13) );
  AOI22X1 U168 ( .A1(FIFO_MEM_2[13]), .A2(n71), .B1(FIFO_MEM_1[13]), .B2(n70), 
        .Q(n16) );
  AOI22X1 U169 ( .A1(FIFO_MEM_4[13]), .A2(n73), .B1(FIFO_MEM_3[13]), .B2(n72), 
        .Q(n15) );
  NAND2XL U170 ( .A(n16), .B(n15), .Q(Data_out[13]) );
  AOI22X1 U171 ( .A1(FIFO_MEM_2[16]), .A2(n71), .B1(FIFO_MEM_1[16]), .B2(n70), 
        .Q(n18) );
  AOI22X1 U172 ( .A1(FIFO_MEM_4[16]), .A2(n73), .B1(FIFO_MEM_3[16]), .B2(n72), 
        .Q(n17) );
  NAND2XL U173 ( .A(n18), .B(n17), .Q(Data_out[16]) );
  AOI22X1 U174 ( .A1(FIFO_MEM_2[15]), .A2(n71), .B1(FIFO_MEM_1[15]), .B2(n70), 
        .Q(n20) );
  AOI22X1 U175 ( .A1(FIFO_MEM_4[15]), .A2(n73), .B1(FIFO_MEM_3[15]), .B2(n72), 
        .Q(n19) );
  NAND2XL U176 ( .A(n20), .B(n19), .Q(Data_out[15]) );
  AOI22X1 U177 ( .A1(read_en), .A2(n102), .B1(n100), .B2(n93), .Q(
        read_pointer_in[1]) );
  AOI22X1 U178 ( .A1(FIFO_MEM_2[9]), .A2(n71), .B1(FIFO_MEM_1[9]), .B2(n70), 
        .Q(n22) );
  AOI22X1 U179 ( .A1(FIFO_MEM_4[9]), .A2(n73), .B1(FIFO_MEM_3[9]), .B2(n72), 
        .Q(n21) );
  NAND2XL U180 ( .A(n22), .B(n21), .Q(Data_out[9]) );
  AOI22X1 U181 ( .A1(FIFO_MEM_2[6]), .A2(n71), .B1(FIFO_MEM_1[6]), .B2(n43), 
        .Q(n24) );
  AOI22X1 U182 ( .A1(FIFO_MEM_4[6]), .A2(n73), .B1(FIFO_MEM_3[6]), .B2(n72), 
        .Q(n23) );
  NAND2XL U183 ( .A(n24), .B(n23), .Q(Data_out[6]) );
  AOI22X1 U184 ( .A1(FIFO_MEM_2[0]), .A2(n71), .B1(FIFO_MEM_1[0]), .B2(n43), 
        .Q(n26) );
  AOI22X1 U185 ( .A1(FIFO_MEM_4[0]), .A2(n73), .B1(FIFO_MEM_3[0]), .B2(n72), 
        .Q(n25) );
  NAND2XL U186 ( .A(n26), .B(n25), .Q(Data_out[0]) );
  AOI22X1 U187 ( .A1(FIFO_MEM_2[10]), .A2(n71), .B1(FIFO_MEM_1[10]), .B2(n70), 
        .Q(n28) );
  AOI22X1 U188 ( .A1(FIFO_MEM_4[10]), .A2(n73), .B1(FIFO_MEM_3[10]), .B2(n72), 
        .Q(n27) );
  NAND2XL U189 ( .A(n28), .B(n27), .Q(Data_out[10]) );
  AOI22X1 U190 ( .A1(FIFO_MEM_2[2]), .A2(n71), .B1(FIFO_MEM_1[2]), .B2(n43), 
        .Q(n30) );
  AOI22X1 U191 ( .A1(FIFO_MEM_4[2]), .A2(n73), .B1(FIFO_MEM_3[2]), .B2(n72), 
        .Q(n29) );
  NAND2XL U192 ( .A(n30), .B(n29), .Q(Data_out[2]) );
  AOI22X1 U193 ( .A1(FIFO_MEM_2[8]), .A2(n71), .B1(FIFO_MEM_1[8]), .B2(n70), 
        .Q(n32) );
  AOI22X1 U194 ( .A1(FIFO_MEM_4[8]), .A2(n73), .B1(FIFO_MEM_3[8]), .B2(n72), 
        .Q(n31) );
  NAND2XL U195 ( .A(n32), .B(n31), .Q(Data_out[8]) );
  AOI22X1 U196 ( .A1(FIFO_MEM_2[7]), .A2(n71), .B1(FIFO_MEM_1[7]), .B2(n70), 
        .Q(n34) );
  AOI22X1 U197 ( .A1(FIFO_MEM_4[7]), .A2(n73), .B1(FIFO_MEM_3[7]), .B2(n72), 
        .Q(n33) );
  NAND2XL U198 ( .A(n34), .B(n33), .Q(Data_out[7]) );
  AOI22X1 U199 ( .A1(FIFO_MEM_2[3]), .A2(n71), .B1(FIFO_MEM_1[3]), .B2(n43), 
        .Q(n36) );
  AOI22X1 U200 ( .A1(FIFO_MEM_4[3]), .A2(n73), .B1(FIFO_MEM_3[3]), .B2(n72), 
        .Q(n35) );
  NAND2XL U201 ( .A(n36), .B(n35), .Q(Data_out[3]) );
  AOI22X1 U202 ( .A1(FIFO_MEM_2[5]), .A2(n71), .B1(FIFO_MEM_1[5]), .B2(n70), 
        .Q(n38) );
  AOI22X1 U203 ( .A1(FIFO_MEM_4[5]), .A2(n73), .B1(FIFO_MEM_3[5]), .B2(n72), 
        .Q(n37) );
  NAND2XL U204 ( .A(n38), .B(n37), .Q(Data_out[5]) );
  AOI22X1 U205 ( .A1(FIFO_MEM_2[4]), .A2(n71), .B1(FIFO_MEM_1[4]), .B2(n43), 
        .Q(n40) );
  AOI22X1 U206 ( .A1(FIFO_MEM_4[4]), .A2(n73), .B1(FIFO_MEM_3[4]), .B2(n72), 
        .Q(n39) );
  NAND2XL U207 ( .A(n40), .B(n39), .Q(Data_out[4]) );
  AOI22X1 U208 ( .A1(FIFO_MEM_2[12]), .A2(n71), .B1(FIFO_MEM_1[12]), .B2(n70), 
        .Q(n42) );
  AOI22X1 U209 ( .A1(FIFO_MEM_4[12]), .A2(n73), .B1(FIFO_MEM_3[12]), .B2(n72), 
        .Q(n41) );
  NAND2XL U210 ( .A(n42), .B(n41), .Q(Data_out[12]) );
  AOI22X1 U211 ( .A1(FIFO_MEM_2[1]), .A2(n71), .B1(FIFO_MEM_1[1]), .B2(n43), 
        .Q(n45) );
  AOI22X1 U212 ( .A1(FIFO_MEM_4[1]), .A2(n73), .B1(FIFO_MEM_3[1]), .B2(n72), 
        .Q(n44) );
  NAND2XL U213 ( .A(n45), .B(n44), .Q(Data_out[1]) );
  AOI22X1 U214 ( .A1(FIFO_MEM_2[11]), .A2(n71), .B1(FIFO_MEM_1[11]), .B2(n43), 
        .Q(n47) );
  AOI22X1 U215 ( .A1(FIFO_MEM_4[11]), .A2(n73), .B1(FIFO_MEM_3[11]), .B2(n72), 
        .Q(n46) );
  NAND2XL U216 ( .A(n47), .B(n46), .Q(Data_out[11]) );
  AOI22X1 U217 ( .A1(FIFO_MEM_2[24]), .A2(n71), .B1(FIFO_MEM_1[24]), .B2(n70), 
        .Q(n49) );
  AOI22X1 U218 ( .A1(FIFO_MEM_4[24]), .A2(n73), .B1(FIFO_MEM_3[24]), .B2(n72), 
        .Q(n48) );
  NAND2XL U219 ( .A(n49), .B(n48), .Q(Data_out[24]) );
  AOI22X1 U220 ( .A1(FIFO_MEM_2[27]), .A2(n71), .B1(FIFO_MEM_1[27]), .B2(n70), 
        .Q(n51) );
  AOI22X1 U221 ( .A1(FIFO_MEM_4[27]), .A2(n73), .B1(FIFO_MEM_3[27]), .B2(n72), 
        .Q(n50) );
  NAND2XL U222 ( .A(n51), .B(n50), .Q(Data_out[27]) );
  AOI22X1 U223 ( .A1(FIFO_MEM_2[20]), .A2(n71), .B1(FIFO_MEM_1[20]), .B2(n70), 
        .Q(n53) );
  AOI22X1 U224 ( .A1(FIFO_MEM_4[20]), .A2(n73), .B1(FIFO_MEM_3[20]), .B2(n72), 
        .Q(n52) );
  NAND2XL U225 ( .A(n53), .B(n52), .Q(Data_out[20]) );
  AOI22X1 U226 ( .A1(FIFO_MEM_2[18]), .A2(n71), .B1(FIFO_MEM_1[18]), .B2(n70), 
        .Q(n55) );
  AOI22X1 U227 ( .A1(FIFO_MEM_4[18]), .A2(n73), .B1(FIFO_MEM_3[18]), .B2(n72), 
        .Q(n54) );
  NAND2XL U228 ( .A(n55), .B(n54), .Q(Data_out[18]) );
  AOI22X1 U229 ( .A1(FIFO_MEM_2[25]), .A2(n71), .B1(FIFO_MEM_1[25]), .B2(n70), 
        .Q(n57) );
  AOI22X1 U230 ( .A1(FIFO_MEM_4[25]), .A2(n73), .B1(FIFO_MEM_3[25]), .B2(n72), 
        .Q(n56) );
  NAND2XL U231 ( .A(n57), .B(n56), .Q(Data_out[25]) );
  AOI22X1 U232 ( .A1(FIFO_MEM_2[17]), .A2(n71), .B1(FIFO_MEM_1[17]), .B2(n70), 
        .Q(n59) );
  AOI22X1 U233 ( .A1(FIFO_MEM_4[17]), .A2(n73), .B1(FIFO_MEM_3[17]), .B2(n72), 
        .Q(n58) );
  NAND2XL U234 ( .A(n59), .B(n58), .Q(Data_out[17]) );
  AOI22X1 U235 ( .A1(FIFO_MEM_2[19]), .A2(n71), .B1(FIFO_MEM_1[19]), .B2(n70), 
        .Q(n61) );
  AOI22X1 U236 ( .A1(FIFO_MEM_4[19]), .A2(n73), .B1(FIFO_MEM_3[19]), .B2(n72), 
        .Q(n60) );
  NAND2XL U237 ( .A(n61), .B(n60), .Q(Data_out[19]) );
  AOI22X1 U238 ( .A1(FIFO_MEM_2[22]), .A2(n71), .B1(FIFO_MEM_1[22]), .B2(n70), 
        .Q(n63) );
  AOI22X1 U239 ( .A1(FIFO_MEM_4[22]), .A2(n73), .B1(FIFO_MEM_3[22]), .B2(n72), 
        .Q(n62) );
  NAND2XL U240 ( .A(n63), .B(n62), .Q(Data_out[22]) );
  AOI22X1 U241 ( .A1(FIFO_MEM_2[21]), .A2(n71), .B1(FIFO_MEM_1[21]), .B2(n70), 
        .Q(n65) );
  AOI22X1 U242 ( .A1(FIFO_MEM_4[21]), .A2(n73), .B1(FIFO_MEM_3[21]), .B2(n72), 
        .Q(n64) );
  NAND2XL U243 ( .A(n65), .B(n64), .Q(Data_out[21]) );
  AOI22X1 U244 ( .A1(FIFO_MEM_2[26]), .A2(n71), .B1(FIFO_MEM_1[26]), .B2(n70), 
        .Q(n67) );
  AOI22X1 U245 ( .A1(FIFO_MEM_4[26]), .A2(n73), .B1(FIFO_MEM_3[26]), .B2(n72), 
        .Q(n66) );
  NAND2XL U246 ( .A(n67), .B(n66), .Q(Data_out[26]) );
  AOI22X1 U247 ( .A1(FIFO_MEM_2[28]), .A2(n71), .B1(FIFO_MEM_1[28]), .B2(n70), 
        .Q(n69) );
  AOI22X1 U248 ( .A1(FIFO_MEM_4[28]), .A2(n73), .B1(FIFO_MEM_3[28]), .B2(n72), 
        .Q(n68) );
  NAND2XL U249 ( .A(n69), .B(n68), .Q(Data_out[28]) );
  AOI22X1 U250 ( .A1(FIFO_MEM_2[23]), .A2(n71), .B1(FIFO_MEM_1[23]), .B2(n70), 
        .Q(n75) );
  AOI22X1 U251 ( .A1(FIFO_MEM_4[23]), .A2(n73), .B1(FIFO_MEM_3[23]), .B2(n72), 
        .Q(n74) );
  NAND2XL U252 ( .A(n75), .B(n74), .Q(Data_out[23]) );
  AOI22X1 U253 ( .A1(n103), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .Q(n76) );
  OAI221X1 U254 ( .A1(n103), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .C1(n76), .Q(n77) );
  AO21X1 U255 ( .A1(write_pointer[1]), .A2(n94), .B1(n83), .Q(
        write_pointer_in[1]) );
  NOR2XL U256 ( .A(write_pointer[2]), .B(write_pointer[1]), .Q(n84) );
  NAND3X1 U257 ( .A(write_pointer[3]), .B(n84), .C(n103), .Q(n80) );
  NOR2XL U258 ( .A(write_pointer[3]), .B(write_pointer[0]), .Q(n87) );
  NAND3X1 U259 ( .A(n101), .B(write_pointer[1]), .C(n87), .Q(n86) );
  NAND3X1 U260 ( .A(write_pointer[2]), .B(n87), .C(n99), .Q(n88) );
  AOI22X1 U261 ( .A1(read_en), .A2(n98), .B1(n102), .B2(n93), .Q(
        read_pointer_in[0]) );
  AOI22X1 U262 ( .A1(read_en), .A2(n100), .B1(n97), .B2(n93), .Q(
        read_pointer_in[2]) );
  AOI22X1 U263 ( .A1(read_en), .A2(n97), .B1(n98), .B2(n93), .Q(
        read_pointer_in[3]) );
  INVXL U264 ( .A(n94), .Q(n95) );
  AOI22X1 U265 ( .A1(n95), .A2(n96), .B1(n103), .B2(n94), .Q(
        write_pointer_in[0]) );
  AOI22X1 U266 ( .A1(n95), .A2(n99), .B1(n101), .B2(n94), .Q(
        write_pointer_in[2]) );
  AOI22X1 U267 ( .A1(n95), .A2(n101), .B1(n96), .B2(n94), .Q(
        write_pointer_in[3]) );
endmodule


module FIFO_credit_based_DATA_WIDTH32_2 ( reset, clk, RX, valid_in, read_en_N, 
        read_en_E, read_en_W, read_en_S, read_en_L, credit_out, empty_out, 
        Data_out );
  input [31:0] RX;
  output [31:0] Data_out;
  input reset, clk, valid_in, read_en_N, read_en_E, read_en_W, read_en_S,
         read_en_L;
  output credit_out, empty_out;
  wire   read_en, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104;
  wire   [3:0] read_pointer;
  wire   [3:0] write_pointer;
  wire   [31:0] FIFO_MEM_1;
  wire   [31:0] FIFO_MEM_2;
  wire   [31:0] FIFO_MEM_3;
  wire   [31:0] FIFO_MEM_4;
  wire   [3:0] write_pointer_in;
  wire   [3:0] read_pointer_in;

  DFPX1 \write_pointer_reg[0]  ( .D(write_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(write_pointer[0]), .QN(n104) );
  DFPX1 \read_pointer_reg[0]  ( .D(read_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(read_pointer[0]), .QN(n103) );
  DFCX1 \write_pointer_reg[1]  ( .D(write_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(write_pointer[1]), .QN(n98) );
  DFCX1 \write_pointer_reg[2]  ( .D(write_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(write_pointer[2]), .QN(n102) );
  DFCX1 \write_pointer_reg[3]  ( .D(write_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(write_pointer[3]), .QN(n100) );
  DFCX1 \read_pointer_reg[3]  ( .D(read_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(read_pointer[3]), .QN(n97) );
  DFCX1 \read_pointer_reg[1]  ( .D(read_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(read_pointer[1]), .QN(n99) );
  DFCX1 \read_pointer_reg[2]  ( .D(read_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(read_pointer[2]), .QN(n101) );
  DFCX1 \FIFO_MEM_1_reg[31]  ( .D(n109), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[31]) );
  DFCX1 \FIFO_MEM_1_reg[30]  ( .D(n110), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[30]) );
  DFCX1 \FIFO_MEM_1_reg[29]  ( .D(n111), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[29]) );
  DFCX1 \FIFO_MEM_1_reg[28]  ( .D(n112), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[28]) );
  DFCX1 \FIFO_MEM_1_reg[27]  ( .D(n113), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[27]) );
  DFCX1 \FIFO_MEM_1_reg[26]  ( .D(n114), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[26]) );
  DFCX1 \FIFO_MEM_1_reg[25]  ( .D(n115), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[25]) );
  DFCX1 \FIFO_MEM_1_reg[24]  ( .D(n116), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[24]) );
  DFCX1 \FIFO_MEM_1_reg[23]  ( .D(n117), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[23]) );
  DFCX1 \FIFO_MEM_1_reg[22]  ( .D(n118), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[22]) );
  DFCX1 \FIFO_MEM_1_reg[21]  ( .D(n119), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[21]) );
  DFCX1 \FIFO_MEM_1_reg[20]  ( .D(n120), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[20]) );
  DFCX1 \FIFO_MEM_1_reg[19]  ( .D(n121), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[19]) );
  DFCX1 \FIFO_MEM_1_reg[18]  ( .D(n122), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[18]) );
  DFCX1 \FIFO_MEM_1_reg[17]  ( .D(n123), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[17]) );
  DFCX1 \FIFO_MEM_1_reg[16]  ( .D(n124), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[16]) );
  DFCX1 \FIFO_MEM_1_reg[15]  ( .D(n125), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[15]) );
  DFCX1 \FIFO_MEM_1_reg[14]  ( .D(n126), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[14]) );
  DFCX1 \FIFO_MEM_1_reg[13]  ( .D(n127), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[13]) );
  DFCX1 \FIFO_MEM_1_reg[12]  ( .D(n128), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[12]) );
  DFCX1 \FIFO_MEM_1_reg[11]  ( .D(n129), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[11]) );
  DFCX1 \FIFO_MEM_1_reg[10]  ( .D(n130), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[10]) );
  DFCX1 \FIFO_MEM_1_reg[9]  ( .D(n131), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[9]) );
  DFCX1 \FIFO_MEM_1_reg[8]  ( .D(n132), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[8]) );
  DFCX1 \FIFO_MEM_1_reg[7]  ( .D(n133), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[7]) );
  DFCX1 \FIFO_MEM_1_reg[6]  ( .D(n134), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[6]) );
  DFCX1 \FIFO_MEM_1_reg[5]  ( .D(n135), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[5]) );
  DFCX1 \FIFO_MEM_1_reg[4]  ( .D(n136), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[4]) );
  DFCX1 \FIFO_MEM_1_reg[3]  ( .D(n137), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[3]) );
  DFCX1 \FIFO_MEM_1_reg[2]  ( .D(n138), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[2]) );
  DFCX1 \FIFO_MEM_1_reg[1]  ( .D(n139), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[1]) );
  DFCX1 \FIFO_MEM_1_reg[0]  ( .D(n140), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[0]) );
  DFCX1 \FIFO_MEM_2_reg[31]  ( .D(n141), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[31]) );
  DFCX1 \FIFO_MEM_2_reg[30]  ( .D(n142), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[30]) );
  DFCX1 \FIFO_MEM_2_reg[29]  ( .D(n143), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[29]) );
  DFCX1 \FIFO_MEM_2_reg[28]  ( .D(n144), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[28]) );
  DFCX1 \FIFO_MEM_2_reg[27]  ( .D(n145), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[27]) );
  DFCX1 \FIFO_MEM_2_reg[26]  ( .D(n146), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[26]) );
  DFCX1 \FIFO_MEM_2_reg[25]  ( .D(n147), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[25]) );
  DFCX1 \FIFO_MEM_2_reg[24]  ( .D(n148), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[24]) );
  DFCX1 \FIFO_MEM_2_reg[23]  ( .D(n149), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[23]) );
  DFCX1 \FIFO_MEM_2_reg[22]  ( .D(n150), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[22]) );
  DFCX1 \FIFO_MEM_2_reg[21]  ( .D(n151), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[21]) );
  DFCX1 \FIFO_MEM_2_reg[20]  ( .D(n152), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[20]) );
  DFCX1 \FIFO_MEM_2_reg[19]  ( .D(n153), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[19]) );
  DFCX1 \FIFO_MEM_2_reg[18]  ( .D(n154), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[18]) );
  DFCX1 \FIFO_MEM_2_reg[17]  ( .D(n155), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[17]) );
  DFCX1 \FIFO_MEM_2_reg[16]  ( .D(n156), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[16]) );
  DFCX1 \FIFO_MEM_2_reg[15]  ( .D(n157), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[15]) );
  DFCX1 \FIFO_MEM_2_reg[14]  ( .D(n158), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[14]) );
  DFCX1 \FIFO_MEM_2_reg[13]  ( .D(n159), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[13]) );
  DFCX1 \FIFO_MEM_2_reg[12]  ( .D(n160), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[12]) );
  DFCX1 \FIFO_MEM_2_reg[11]  ( .D(n161), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[11]) );
  DFCX1 \FIFO_MEM_2_reg[10]  ( .D(n162), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[10]) );
  DFCX1 \FIFO_MEM_2_reg[9]  ( .D(n163), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[9]) );
  DFCX1 \FIFO_MEM_2_reg[8]  ( .D(n164), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[8]) );
  DFCX1 \FIFO_MEM_2_reg[7]  ( .D(n165), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[7]) );
  DFCX1 \FIFO_MEM_2_reg[6]  ( .D(n166), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[6]) );
  DFCX1 \FIFO_MEM_2_reg[5]  ( .D(n167), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[5]) );
  DFCX1 \FIFO_MEM_2_reg[4]  ( .D(n168), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[4]) );
  DFCX1 \FIFO_MEM_2_reg[3]  ( .D(n169), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[3]) );
  DFCX1 \FIFO_MEM_2_reg[2]  ( .D(n170), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[2]) );
  DFCX1 \FIFO_MEM_2_reg[1]  ( .D(n171), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[1]) );
  DFCX1 \FIFO_MEM_2_reg[0]  ( .D(n172), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[0]) );
  DFCX1 \FIFO_MEM_3_reg[31]  ( .D(n173), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[31]) );
  DFCX1 \FIFO_MEM_3_reg[30]  ( .D(n174), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[30]) );
  DFCX1 \FIFO_MEM_3_reg[29]  ( .D(n175), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[29]) );
  DFCX1 \FIFO_MEM_3_reg[28]  ( .D(n176), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[28]) );
  DFCX1 \FIFO_MEM_3_reg[27]  ( .D(n177), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[27]) );
  DFCX1 \FIFO_MEM_3_reg[26]  ( .D(n178), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[26]) );
  DFCX1 \FIFO_MEM_3_reg[25]  ( .D(n179), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[25]) );
  DFCX1 \FIFO_MEM_3_reg[24]  ( .D(n180), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[24]) );
  DFCX1 \FIFO_MEM_3_reg[23]  ( .D(n181), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[23]) );
  DFCX1 \FIFO_MEM_3_reg[22]  ( .D(n182), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[22]) );
  DFCX1 \FIFO_MEM_3_reg[21]  ( .D(n183), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[21]) );
  DFCX1 \FIFO_MEM_3_reg[20]  ( .D(n184), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[20]) );
  DFCX1 \FIFO_MEM_3_reg[19]  ( .D(n185), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[19]) );
  DFCX1 \FIFO_MEM_3_reg[18]  ( .D(n186), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[18]) );
  DFCX1 \FIFO_MEM_3_reg[17]  ( .D(n187), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[17]) );
  DFCX1 \FIFO_MEM_3_reg[16]  ( .D(n188), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[16]) );
  DFCX1 \FIFO_MEM_3_reg[15]  ( .D(n189), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[15]) );
  DFCX1 \FIFO_MEM_3_reg[14]  ( .D(n190), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[14]) );
  DFCX1 \FIFO_MEM_3_reg[13]  ( .D(n191), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[13]) );
  DFCX1 \FIFO_MEM_3_reg[12]  ( .D(n192), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[12]) );
  DFCX1 \FIFO_MEM_3_reg[11]  ( .D(n193), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[11]) );
  DFCX1 \FIFO_MEM_3_reg[10]  ( .D(n194), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[10]) );
  DFCX1 \FIFO_MEM_3_reg[9]  ( .D(n195), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[9]) );
  DFCX1 \FIFO_MEM_3_reg[8]  ( .D(n196), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[8]) );
  DFCX1 \FIFO_MEM_3_reg[7]  ( .D(n197), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[7]) );
  DFCX1 \FIFO_MEM_3_reg[6]  ( .D(n198), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[6]) );
  DFCX1 \FIFO_MEM_3_reg[5]  ( .D(n199), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[5]) );
  DFCX1 \FIFO_MEM_3_reg[4]  ( .D(n200), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[4]) );
  DFCX1 \FIFO_MEM_3_reg[3]  ( .D(n201), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[3]) );
  DFCX1 \FIFO_MEM_3_reg[2]  ( .D(n202), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[2]) );
  DFCX1 \FIFO_MEM_3_reg[1]  ( .D(n203), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[1]) );
  DFCX1 \FIFO_MEM_3_reg[0]  ( .D(n204), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[0]) );
  DFCX1 \FIFO_MEM_4_reg[31]  ( .D(n205), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[31]) );
  DFCX1 \FIFO_MEM_4_reg[30]  ( .D(n206), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[30]) );
  DFCX1 \FIFO_MEM_4_reg[29]  ( .D(n207), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[29]) );
  DFCX1 \FIFO_MEM_4_reg[28]  ( .D(n208), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[28]) );
  DFCX1 \FIFO_MEM_4_reg[27]  ( .D(n209), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[27]) );
  DFCX1 \FIFO_MEM_4_reg[26]  ( .D(n210), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[26]) );
  DFCX1 \FIFO_MEM_4_reg[25]  ( .D(n211), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[25]) );
  DFCX1 \FIFO_MEM_4_reg[24]  ( .D(n212), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[24]) );
  DFCX1 \FIFO_MEM_4_reg[23]  ( .D(n213), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[23]) );
  DFCX1 \FIFO_MEM_4_reg[22]  ( .D(n214), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[22]) );
  DFCX1 \FIFO_MEM_4_reg[21]  ( .D(n215), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[21]) );
  DFCX1 \FIFO_MEM_4_reg[20]  ( .D(n216), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[20]) );
  DFCX1 \FIFO_MEM_4_reg[19]  ( .D(n217), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[19]) );
  DFCX1 \FIFO_MEM_4_reg[18]  ( .D(n218), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[18]) );
  DFCX1 \FIFO_MEM_4_reg[17]  ( .D(n219), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[17]) );
  DFCX1 \FIFO_MEM_4_reg[16]  ( .D(n220), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[16]) );
  DFCX1 \FIFO_MEM_4_reg[15]  ( .D(n221), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[15]) );
  DFCX1 \FIFO_MEM_4_reg[14]  ( .D(n222), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[14]) );
  DFCX1 \FIFO_MEM_4_reg[13]  ( .D(n223), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[13]) );
  DFCX1 \FIFO_MEM_4_reg[12]  ( .D(n224), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[12]) );
  DFCX1 \FIFO_MEM_4_reg[11]  ( .D(n225), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[11]) );
  DFCX1 \FIFO_MEM_4_reg[10]  ( .D(n226), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[10]) );
  DFCX1 \FIFO_MEM_4_reg[9]  ( .D(n227), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[9]) );
  DFCX1 \FIFO_MEM_4_reg[8]  ( .D(n228), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[8]) );
  DFCX1 \FIFO_MEM_4_reg[7]  ( .D(n229), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[7]) );
  DFCX1 \FIFO_MEM_4_reg[6]  ( .D(n230), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[6]) );
  DFCX1 \FIFO_MEM_4_reg[5]  ( .D(n231), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[5]) );
  DFCX1 \FIFO_MEM_4_reg[4]  ( .D(n232), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[4]) );
  DFCX1 \FIFO_MEM_4_reg[3]  ( .D(n233), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[3]) );
  DFCX1 \FIFO_MEM_4_reg[2]  ( .D(n234), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[2]) );
  DFCX1 \FIFO_MEM_4_reg[1]  ( .D(n235), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[1]) );
  DFCX1 \FIFO_MEM_4_reg[0]  ( .D(n236), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[0]) );
  DFCX1 credit_out_reg ( .D(read_en), .CP(clk), .RN(reset), .Q(credit_out) );
  AND3X2 U3 ( .A(n85), .B(n84), .C(n100), .Q(n86) );
  CLKINVX2 U4 ( .A(n86), .Q(n1) );
  NAND2X3 U5 ( .A(valid_in), .B(n80), .Q(n95) );
  AOI221X2 U6 ( .A1(write_pointer[3]), .A2(n97), .B1(n100), .B2(
        read_pointer[3]), .C1(n4), .Q(empty_out) );
  OAI221X2 U7 ( .A1(write_pointer[2]), .A2(n97), .B1(n102), .B2(
        read_pointer[3]), .C1(n79), .Q(n80) );
  AOI221X2 U8 ( .A1(write_pointer[1]), .A2(n101), .B1(n98), .B2(
        read_pointer[2]), .C1(n78), .Q(n79) );
  AO22X2 U9 ( .A1(n86), .A2(RX[11]), .B1(n1), .B2(FIFO_MEM_1[11]), .Q(n129) );
  AO22X2 U10 ( .A1(n86), .A2(RX[9]), .B1(n1), .B2(FIFO_MEM_1[9]), .Q(n131) );
  AO22X2 U11 ( .A1(n86), .A2(RX[10]), .B1(n1), .B2(FIFO_MEM_1[10]), .Q(n130)
         );
  AO22X2 U12 ( .A1(n86), .A2(RX[8]), .B1(n1), .B2(FIFO_MEM_1[8]), .Q(n132) );
  AO22X2 U13 ( .A1(n86), .A2(RX[7]), .B1(n1), .B2(FIFO_MEM_1[7]), .Q(n133) );
  AO22X2 U14 ( .A1(n86), .A2(RX[6]), .B1(n1), .B2(FIFO_MEM_1[6]), .Q(n134) );
  AO22X2 U15 ( .A1(n86), .A2(RX[5]), .B1(n1), .B2(FIFO_MEM_1[5]), .Q(n135) );
  AO22X2 U16 ( .A1(n86), .A2(RX[0]), .B1(n1), .B2(FIFO_MEM_1[0]), .Q(n140) );
  AO22X2 U17 ( .A1(n86), .A2(RX[1]), .B1(n1), .B2(FIFO_MEM_1[1]), .Q(n139) );
  AO22X2 U18 ( .A1(n86), .A2(RX[4]), .B1(n1), .B2(FIFO_MEM_1[4]), .Q(n136) );
  AO22X2 U19 ( .A1(n86), .A2(RX[2]), .B1(n1), .B2(FIFO_MEM_1[2]), .Q(n138) );
  AO22X2 U20 ( .A1(n86), .A2(RX[3]), .B1(n1), .B2(FIFO_MEM_1[3]), .Q(n137) );
  AO22X2 U21 ( .A1(n86), .A2(RX[14]), .B1(n1), .B2(FIFO_MEM_1[14]), .Q(n126)
         );
  AO22X2 U22 ( .A1(n86), .A2(RX[12]), .B1(n1), .B2(FIFO_MEM_1[12]), .Q(n128)
         );
  AO22X2 U23 ( .A1(n86), .A2(RX[13]), .B1(n1), .B2(FIFO_MEM_1[13]), .Q(n127)
         );
  INVX1 U24 ( .A(read_en), .Q(n94) );
  NOR4X3 U25 ( .A(read_pointer[0]), .B(read_pointer[3]), .C(read_pointer[2]), 
        .D(n99), .Q(n72) );
  AOI221X1 U26 ( .A1(n98), .A2(read_pointer[1]), .B1(write_pointer[0]), .B2(
        n103), .C1(n2), .Q(n3) );
  OAI22X1 U27 ( .A1(n98), .A2(read_pointer[1]), .B1(n103), .B2(
        write_pointer[0]), .Q(n2) );
  NOR2X3 U28 ( .A(n95), .B(n81), .Q(n83) );
  NOR2X3 U29 ( .A(n89), .B(n95), .Q(n91) );
  NOR2X3 U30 ( .A(n87), .B(n95), .Q(n93) );
  NOR2XL U31 ( .A(n104), .B(n95), .Q(n84) );
  CLKBUFX2 U32 ( .A(n11), .Q(n71) );
  BUFX2 U33 ( .A(n72), .Q(n68) );
  CLKINVX2 U34 ( .A(n83), .Q(n82) );
  CLKINVX2 U35 ( .A(n91), .Q(n90) );
  CLKINVX2 U36 ( .A(n93), .Q(n92) );
  NOR2XL U37 ( .A(empty_out), .B(n5), .Q(read_en) );
  NOR4X1 U38 ( .A(read_en_N), .B(read_en_E), .C(read_en_S), .D(read_en_L), .Q(
        n5) );
  AO22X1 U39 ( .A1(n83), .A2(RX[0]), .B1(FIFO_MEM_4[0]), .B2(n82), .Q(n236) );
  AO22X1 U40 ( .A1(RX[1]), .A2(n83), .B1(FIFO_MEM_4[1]), .B2(n82), .Q(n235) );
  AO22X1 U41 ( .A1(RX[2]), .A2(n83), .B1(FIFO_MEM_4[2]), .B2(n82), .Q(n234) );
  AO22X1 U42 ( .A1(RX[3]), .A2(n83), .B1(FIFO_MEM_4[3]), .B2(n82), .Q(n233) );
  AO22X1 U43 ( .A1(RX[4]), .A2(n83), .B1(FIFO_MEM_4[4]), .B2(n82), .Q(n232) );
  AO22X1 U44 ( .A1(RX[5]), .A2(n83), .B1(FIFO_MEM_4[5]), .B2(n82), .Q(n231) );
  AO22X1 U45 ( .A1(RX[6]), .A2(n83), .B1(FIFO_MEM_4[6]), .B2(n82), .Q(n230) );
  AO22X1 U46 ( .A1(RX[7]), .A2(n83), .B1(FIFO_MEM_4[7]), .B2(n82), .Q(n229) );
  AO22X1 U47 ( .A1(RX[8]), .A2(n83), .B1(FIFO_MEM_4[8]), .B2(n82), .Q(n228) );
  AO22X1 U48 ( .A1(RX[9]), .A2(n83), .B1(FIFO_MEM_4[9]), .B2(n82), .Q(n227) );
  AO22X1 U49 ( .A1(RX[10]), .A2(n83), .B1(FIFO_MEM_4[10]), .B2(n82), .Q(n226)
         );
  AO22X1 U50 ( .A1(RX[11]), .A2(n83), .B1(FIFO_MEM_4[11]), .B2(n82), .Q(n225)
         );
  AO22X1 U51 ( .A1(RX[12]), .A2(n83), .B1(FIFO_MEM_4[12]), .B2(n82), .Q(n224)
         );
  AO22X1 U52 ( .A1(RX[13]), .A2(n83), .B1(FIFO_MEM_4[13]), .B2(n82), .Q(n223)
         );
  AO22X1 U53 ( .A1(RX[14]), .A2(n83), .B1(FIFO_MEM_4[14]), .B2(n82), .Q(n222)
         );
  AO22X1 U54 ( .A1(RX[15]), .A2(n83), .B1(FIFO_MEM_4[15]), .B2(n82), .Q(n221)
         );
  AO22X1 U55 ( .A1(RX[16]), .A2(n83), .B1(FIFO_MEM_4[16]), .B2(n82), .Q(n220)
         );
  AO22X1 U56 ( .A1(RX[17]), .A2(n83), .B1(FIFO_MEM_4[17]), .B2(n82), .Q(n219)
         );
  AO22X1 U57 ( .A1(RX[18]), .A2(n83), .B1(FIFO_MEM_4[18]), .B2(n82), .Q(n218)
         );
  AO22X1 U58 ( .A1(RX[19]), .A2(n83), .B1(FIFO_MEM_4[19]), .B2(n82), .Q(n217)
         );
  AO22X1 U59 ( .A1(RX[20]), .A2(n83), .B1(FIFO_MEM_4[20]), .B2(n82), .Q(n216)
         );
  AO22X1 U60 ( .A1(RX[21]), .A2(n83), .B1(FIFO_MEM_4[21]), .B2(n82), .Q(n215)
         );
  AO22X1 U61 ( .A1(RX[22]), .A2(n83), .B1(FIFO_MEM_4[22]), .B2(n82), .Q(n214)
         );
  AO22X1 U62 ( .A1(RX[23]), .A2(n83), .B1(FIFO_MEM_4[23]), .B2(n82), .Q(n213)
         );
  AO22X1 U63 ( .A1(RX[24]), .A2(n83), .B1(FIFO_MEM_4[24]), .B2(n82), .Q(n212)
         );
  AO22X1 U64 ( .A1(RX[25]), .A2(n83), .B1(FIFO_MEM_4[25]), .B2(n82), .Q(n211)
         );
  AO22X1 U65 ( .A1(RX[26]), .A2(n83), .B1(FIFO_MEM_4[26]), .B2(n82), .Q(n210)
         );
  AO22X1 U66 ( .A1(RX[27]), .A2(n83), .B1(FIFO_MEM_4[27]), .B2(n82), .Q(n209)
         );
  AO22X1 U67 ( .A1(RX[28]), .A2(n83), .B1(FIFO_MEM_4[28]), .B2(n82), .Q(n208)
         );
  AO22X1 U68 ( .A1(RX[29]), .A2(n83), .B1(FIFO_MEM_4[29]), .B2(n82), .Q(n207)
         );
  AO22X1 U69 ( .A1(RX[30]), .A2(n83), .B1(FIFO_MEM_4[30]), .B2(n82), .Q(n206)
         );
  AO22X1 U70 ( .A1(RX[31]), .A2(n83), .B1(FIFO_MEM_4[31]), .B2(n82), .Q(n205)
         );
  AO22X1 U71 ( .A1(RX[0]), .A2(n91), .B1(FIFO_MEM_3[0]), .B2(n90), .Q(n204) );
  AO22X1 U72 ( .A1(RX[1]), .A2(n91), .B1(FIFO_MEM_3[1]), .B2(n90), .Q(n203) );
  AO22X1 U73 ( .A1(RX[2]), .A2(n91), .B1(FIFO_MEM_3[2]), .B2(n90), .Q(n202) );
  AO22X1 U74 ( .A1(RX[3]), .A2(n91), .B1(FIFO_MEM_3[3]), .B2(n90), .Q(n201) );
  AO22X1 U75 ( .A1(RX[4]), .A2(n91), .B1(FIFO_MEM_3[4]), .B2(n90), .Q(n200) );
  AO22X1 U76 ( .A1(RX[5]), .A2(n91), .B1(FIFO_MEM_3[5]), .B2(n90), .Q(n199) );
  AO22X1 U77 ( .A1(RX[6]), .A2(n91), .B1(FIFO_MEM_3[6]), .B2(n90), .Q(n198) );
  AO22X1 U78 ( .A1(RX[7]), .A2(n91), .B1(FIFO_MEM_3[7]), .B2(n90), .Q(n197) );
  AO22X1 U79 ( .A1(RX[8]), .A2(n91), .B1(FIFO_MEM_3[8]), .B2(n90), .Q(n196) );
  AO22X1 U80 ( .A1(RX[9]), .A2(n91), .B1(FIFO_MEM_3[9]), .B2(n90), .Q(n195) );
  AO22X1 U81 ( .A1(RX[10]), .A2(n91), .B1(FIFO_MEM_3[10]), .B2(n90), .Q(n194)
         );
  AO22X1 U82 ( .A1(RX[11]), .A2(n91), .B1(FIFO_MEM_3[11]), .B2(n90), .Q(n193)
         );
  AO22X1 U83 ( .A1(RX[12]), .A2(n91), .B1(FIFO_MEM_3[12]), .B2(n90), .Q(n192)
         );
  AO22X1 U84 ( .A1(RX[13]), .A2(n91), .B1(FIFO_MEM_3[13]), .B2(n90), .Q(n191)
         );
  AO22X1 U85 ( .A1(RX[14]), .A2(n91), .B1(FIFO_MEM_3[14]), .B2(n90), .Q(n190)
         );
  AO22X1 U86 ( .A1(RX[15]), .A2(n91), .B1(FIFO_MEM_3[15]), .B2(n90), .Q(n189)
         );
  AO22X1 U87 ( .A1(RX[16]), .A2(n91), .B1(FIFO_MEM_3[16]), .B2(n90), .Q(n188)
         );
  AO22X1 U88 ( .A1(RX[17]), .A2(n91), .B1(FIFO_MEM_3[17]), .B2(n90), .Q(n187)
         );
  AO22X1 U89 ( .A1(RX[18]), .A2(n91), .B1(FIFO_MEM_3[18]), .B2(n90), .Q(n186)
         );
  AO22X1 U90 ( .A1(RX[19]), .A2(n91), .B1(FIFO_MEM_3[19]), .B2(n90), .Q(n185)
         );
  AO22X1 U91 ( .A1(RX[20]), .A2(n91), .B1(FIFO_MEM_3[20]), .B2(n90), .Q(n184)
         );
  AO22X1 U92 ( .A1(RX[21]), .A2(n91), .B1(FIFO_MEM_3[21]), .B2(n90), .Q(n183)
         );
  AO22X1 U93 ( .A1(RX[22]), .A2(n91), .B1(FIFO_MEM_3[22]), .B2(n90), .Q(n182)
         );
  AO22X1 U94 ( .A1(RX[23]), .A2(n91), .B1(FIFO_MEM_3[23]), .B2(n90), .Q(n181)
         );
  AO22X1 U95 ( .A1(RX[24]), .A2(n91), .B1(FIFO_MEM_3[24]), .B2(n90), .Q(n180)
         );
  AO22X1 U96 ( .A1(RX[25]), .A2(n91), .B1(FIFO_MEM_3[25]), .B2(n90), .Q(n179)
         );
  AO22X1 U97 ( .A1(RX[26]), .A2(n91), .B1(FIFO_MEM_3[26]), .B2(n90), .Q(n178)
         );
  AO22X1 U98 ( .A1(RX[27]), .A2(n91), .B1(FIFO_MEM_3[27]), .B2(n90), .Q(n177)
         );
  AO22X1 U99 ( .A1(RX[28]), .A2(n91), .B1(FIFO_MEM_3[28]), .B2(n90), .Q(n176)
         );
  AO22X1 U100 ( .A1(RX[29]), .A2(n91), .B1(FIFO_MEM_3[29]), .B2(n90), .Q(n175)
         );
  AO22X1 U101 ( .A1(RX[30]), .A2(n91), .B1(FIFO_MEM_3[30]), .B2(n90), .Q(n174)
         );
  AO22X1 U102 ( .A1(RX[31]), .A2(n91), .B1(FIFO_MEM_3[31]), .B2(n90), .Q(n173)
         );
  AO22X1 U103 ( .A1(RX[0]), .A2(n93), .B1(FIFO_MEM_2[0]), .B2(n92), .Q(n172)
         );
  AO22X1 U104 ( .A1(RX[1]), .A2(n93), .B1(FIFO_MEM_2[1]), .B2(n92), .Q(n171)
         );
  AO22X1 U105 ( .A1(RX[2]), .A2(n93), .B1(FIFO_MEM_2[2]), .B2(n92), .Q(n170)
         );
  AO22X1 U106 ( .A1(RX[3]), .A2(n93), .B1(FIFO_MEM_2[3]), .B2(n92), .Q(n169)
         );
  AO22X1 U107 ( .A1(RX[4]), .A2(n93), .B1(FIFO_MEM_2[4]), .B2(n92), .Q(n168)
         );
  AO22X1 U108 ( .A1(RX[5]), .A2(n93), .B1(FIFO_MEM_2[5]), .B2(n92), .Q(n167)
         );
  AO22X1 U109 ( .A1(RX[6]), .A2(n93), .B1(FIFO_MEM_2[6]), .B2(n92), .Q(n166)
         );
  AO22X1 U110 ( .A1(RX[7]), .A2(n93), .B1(FIFO_MEM_2[7]), .B2(n92), .Q(n165)
         );
  AO22X1 U111 ( .A1(RX[8]), .A2(n93), .B1(FIFO_MEM_2[8]), .B2(n92), .Q(n164)
         );
  AO22X1 U112 ( .A1(RX[9]), .A2(n93), .B1(FIFO_MEM_2[9]), .B2(n92), .Q(n163)
         );
  AO22X1 U113 ( .A1(RX[10]), .A2(n93), .B1(FIFO_MEM_2[10]), .B2(n92), .Q(n162)
         );
  AO22X1 U114 ( .A1(RX[11]), .A2(n93), .B1(FIFO_MEM_2[11]), .B2(n92), .Q(n161)
         );
  AO22X1 U115 ( .A1(RX[12]), .A2(n93), .B1(FIFO_MEM_2[12]), .B2(n92), .Q(n160)
         );
  AO22X1 U116 ( .A1(RX[13]), .A2(n93), .B1(FIFO_MEM_2[13]), .B2(n92), .Q(n159)
         );
  AO22X1 U117 ( .A1(RX[14]), .A2(n93), .B1(FIFO_MEM_2[14]), .B2(n92), .Q(n158)
         );
  AO22X1 U118 ( .A1(RX[15]), .A2(n93), .B1(FIFO_MEM_2[15]), .B2(n92), .Q(n157)
         );
  AO22X1 U119 ( .A1(RX[16]), .A2(n93), .B1(FIFO_MEM_2[16]), .B2(n92), .Q(n156)
         );
  AO22X1 U120 ( .A1(RX[17]), .A2(n93), .B1(FIFO_MEM_2[17]), .B2(n92), .Q(n155)
         );
  AO22X1 U121 ( .A1(RX[18]), .A2(n93), .B1(FIFO_MEM_2[18]), .B2(n92), .Q(n154)
         );
  AO22X1 U122 ( .A1(RX[19]), .A2(n93), .B1(FIFO_MEM_2[19]), .B2(n92), .Q(n153)
         );
  AO22X1 U123 ( .A1(RX[20]), .A2(n93), .B1(FIFO_MEM_2[20]), .B2(n92), .Q(n152)
         );
  AO22X1 U124 ( .A1(RX[21]), .A2(n93), .B1(FIFO_MEM_2[21]), .B2(n92), .Q(n151)
         );
  AO22X1 U125 ( .A1(RX[22]), .A2(n93), .B1(FIFO_MEM_2[22]), .B2(n92), .Q(n150)
         );
  AO22X1 U126 ( .A1(RX[23]), .A2(n93), .B1(FIFO_MEM_2[23]), .B2(n92), .Q(n149)
         );
  AO22X1 U127 ( .A1(RX[24]), .A2(n93), .B1(FIFO_MEM_2[24]), .B2(n92), .Q(n148)
         );
  AO22X1 U128 ( .A1(RX[25]), .A2(n93), .B1(FIFO_MEM_2[25]), .B2(n92), .Q(n147)
         );
  AO22X1 U129 ( .A1(RX[26]), .A2(n93), .B1(FIFO_MEM_2[26]), .B2(n92), .Q(n146)
         );
  AO22X1 U130 ( .A1(RX[27]), .A2(n93), .B1(FIFO_MEM_2[27]), .B2(n92), .Q(n145)
         );
  AO22X1 U131 ( .A1(RX[28]), .A2(n93), .B1(FIFO_MEM_2[28]), .B2(n92), .Q(n144)
         );
  AO22X1 U132 ( .A1(RX[29]), .A2(n93), .B1(FIFO_MEM_2[29]), .B2(n92), .Q(n143)
         );
  AO22X1 U133 ( .A1(RX[30]), .A2(n93), .B1(FIFO_MEM_2[30]), .B2(n92), .Q(n142)
         );
  AO22X1 U134 ( .A1(RX[31]), .A2(n93), .B1(FIFO_MEM_2[31]), .B2(n92), .Q(n141)
         );
  AO22X1 U135 ( .A1(n86), .A2(RX[30]), .B1(n1), .B2(FIFO_MEM_1[30]), .Q(n110)
         );
  AO22X1 U136 ( .A1(n86), .A2(RX[31]), .B1(n1), .B2(FIFO_MEM_1[31]), .Q(n109)
         );
  NAND2XL U137 ( .A(n103), .B(n99), .Q(n6) );
  AOI22X1 U138 ( .A1(FIFO_MEM_2[29]), .A2(n68), .B1(FIFO_MEM_1[29]), .B2(n71), 
        .Q(n8) );
  NAND2XL U139 ( .A(n8), .B(n7), .Q(Data_out[29]) );
  OAI221X1 U140 ( .A1(write_pointer[2]), .A2(n101), .B1(n102), .B2(
        read_pointer[2]), .C1(n3), .Q(n4) );
  NOR3X6 U141 ( .A(read_pointer[3]), .B(n101), .C(n6), .Q(n73) );
  NOR3X6 U142 ( .A(read_pointer[2]), .B(n97), .C(n6), .Q(n74) );
  NOR3X3 U143 ( .A(n73), .B(n74), .C(n68), .Q(n11) );
  AOI22X1 U144 ( .A1(FIFO_MEM_4[29]), .A2(n74), .B1(FIFO_MEM_3[29]), .B2(n73), 
        .Q(n7) );
  AOI22X1 U145 ( .A1(FIFO_MEM_2[31]), .A2(n68), .B1(FIFO_MEM_1[31]), .B2(n11), 
        .Q(n10) );
  AOI22X1 U146 ( .A1(FIFO_MEM_4[31]), .A2(n74), .B1(FIFO_MEM_3[31]), .B2(n73), 
        .Q(n9) );
  NAND2XL U147 ( .A(n10), .B(n9), .Q(Data_out[31]) );
  AOI22X1 U148 ( .A1(FIFO_MEM_2[30]), .A2(n68), .B1(FIFO_MEM_1[30]), .B2(n11), 
        .Q(n13) );
  AOI22X1 U149 ( .A1(FIFO_MEM_4[30]), .A2(n74), .B1(FIFO_MEM_3[30]), .B2(n73), 
        .Q(n12) );
  NAND2XL U150 ( .A(n13), .B(n12), .Q(Data_out[30]) );
  AOI22X1 U151 ( .A1(FIFO_MEM_2[14]), .A2(n68), .B1(FIFO_MEM_1[14]), .B2(n71), 
        .Q(n15) );
  AOI22X1 U152 ( .A1(FIFO_MEM_4[14]), .A2(n74), .B1(FIFO_MEM_3[14]), .B2(n73), 
        .Q(n14) );
  NAND2XL U153 ( .A(n15), .B(n14), .Q(Data_out[14]) );
  AOI22X1 U154 ( .A1(FIFO_MEM_2[13]), .A2(n68), .B1(FIFO_MEM_1[13]), .B2(n71), 
        .Q(n17) );
  AOI22X1 U155 ( .A1(FIFO_MEM_4[13]), .A2(n74), .B1(FIFO_MEM_3[13]), .B2(n73), 
        .Q(n16) );
  NAND2XL U156 ( .A(n17), .B(n16), .Q(Data_out[13]) );
  AOI22X1 U157 ( .A1(FIFO_MEM_2[16]), .A2(n68), .B1(FIFO_MEM_1[16]), .B2(n71), 
        .Q(n19) );
  AOI22X1 U158 ( .A1(FIFO_MEM_4[16]), .A2(n74), .B1(FIFO_MEM_3[16]), .B2(n73), 
        .Q(n18) );
  NAND2XL U159 ( .A(n19), .B(n18), .Q(Data_out[16]) );
  AOI22X1 U160 ( .A1(FIFO_MEM_2[15]), .A2(n68), .B1(FIFO_MEM_1[15]), .B2(n71), 
        .Q(n21) );
  AOI22X1 U161 ( .A1(FIFO_MEM_4[15]), .A2(n74), .B1(FIFO_MEM_3[15]), .B2(n73), 
        .Q(n20) );
  NAND2XL U162 ( .A(n21), .B(n20), .Q(Data_out[15]) );
  AOI22X1 U163 ( .A1(FIFO_MEM_2[9]), .A2(n68), .B1(FIFO_MEM_1[9]), .B2(n71), 
        .Q(n23) );
  AOI22X1 U164 ( .A1(FIFO_MEM_4[9]), .A2(n74), .B1(FIFO_MEM_3[9]), .B2(n73), 
        .Q(n22) );
  NAND2XL U165 ( .A(n23), .B(n22), .Q(Data_out[9]) );
  AOI22X1 U166 ( .A1(FIFO_MEM_2[6]), .A2(n68), .B1(FIFO_MEM_1[6]), .B2(n71), 
        .Q(n25) );
  AOI22X1 U167 ( .A1(FIFO_MEM_4[6]), .A2(n74), .B1(FIFO_MEM_3[6]), .B2(n73), 
        .Q(n24) );
  NAND2XL U168 ( .A(n25), .B(n24), .Q(Data_out[6]) );
  AOI22X1 U169 ( .A1(FIFO_MEM_2[0]), .A2(n68), .B1(FIFO_MEM_1[0]), .B2(n71), 
        .Q(n27) );
  AOI22X1 U170 ( .A1(FIFO_MEM_4[0]), .A2(n74), .B1(FIFO_MEM_3[0]), .B2(n73), 
        .Q(n26) );
  NAND2XL U171 ( .A(n27), .B(n26), .Q(Data_out[0]) );
  AOI22X1 U172 ( .A1(FIFO_MEM_2[10]), .A2(n68), .B1(FIFO_MEM_1[10]), .B2(n71), 
        .Q(n29) );
  AOI22X1 U173 ( .A1(FIFO_MEM_4[10]), .A2(n74), .B1(FIFO_MEM_3[10]), .B2(n73), 
        .Q(n28) );
  NAND2XL U174 ( .A(n29), .B(n28), .Q(Data_out[10]) );
  AOI22X1 U175 ( .A1(FIFO_MEM_2[2]), .A2(n68), .B1(FIFO_MEM_1[2]), .B2(n71), 
        .Q(n31) );
  AOI22X1 U176 ( .A1(FIFO_MEM_4[2]), .A2(n74), .B1(FIFO_MEM_3[2]), .B2(n73), 
        .Q(n30) );
  NAND2XL U177 ( .A(n31), .B(n30), .Q(Data_out[2]) );
  AOI22X1 U178 ( .A1(FIFO_MEM_2[8]), .A2(n68), .B1(FIFO_MEM_1[8]), .B2(n71), 
        .Q(n33) );
  AOI22X1 U179 ( .A1(FIFO_MEM_4[8]), .A2(n74), .B1(FIFO_MEM_3[8]), .B2(n73), 
        .Q(n32) );
  NAND2XL U180 ( .A(n33), .B(n32), .Q(Data_out[8]) );
  AOI22X1 U181 ( .A1(FIFO_MEM_2[7]), .A2(n68), .B1(FIFO_MEM_1[7]), .B2(n71), 
        .Q(n35) );
  AOI22X1 U182 ( .A1(FIFO_MEM_4[7]), .A2(n74), .B1(FIFO_MEM_3[7]), .B2(n73), 
        .Q(n34) );
  NAND2XL U183 ( .A(n35), .B(n34), .Q(Data_out[7]) );
  AOI22X1 U184 ( .A1(FIFO_MEM_2[3]), .A2(n68), .B1(FIFO_MEM_1[3]), .B2(n71), 
        .Q(n37) );
  AOI22X1 U185 ( .A1(FIFO_MEM_4[3]), .A2(n74), .B1(FIFO_MEM_3[3]), .B2(n73), 
        .Q(n36) );
  NAND2XL U186 ( .A(n37), .B(n36), .Q(Data_out[3]) );
  AOI22X1 U187 ( .A1(FIFO_MEM_2[5]), .A2(n68), .B1(FIFO_MEM_1[5]), .B2(n71), 
        .Q(n39) );
  AOI22X1 U188 ( .A1(FIFO_MEM_4[5]), .A2(n74), .B1(FIFO_MEM_3[5]), .B2(n73), 
        .Q(n38) );
  NAND2XL U189 ( .A(n39), .B(n38), .Q(Data_out[5]) );
  AOI22X1 U190 ( .A1(FIFO_MEM_2[4]), .A2(n68), .B1(FIFO_MEM_1[4]), .B2(n71), 
        .Q(n41) );
  AOI22X1 U191 ( .A1(FIFO_MEM_4[4]), .A2(n74), .B1(FIFO_MEM_3[4]), .B2(n73), 
        .Q(n40) );
  NAND2XL U192 ( .A(n41), .B(n40), .Q(Data_out[4]) );
  AOI22X1 U193 ( .A1(FIFO_MEM_2[12]), .A2(n68), .B1(FIFO_MEM_1[12]), .B2(n71), 
        .Q(n43) );
  AOI22X1 U194 ( .A1(FIFO_MEM_4[12]), .A2(n74), .B1(FIFO_MEM_3[12]), .B2(n73), 
        .Q(n42) );
  NAND2XL U195 ( .A(n43), .B(n42), .Q(Data_out[12]) );
  AOI22X1 U196 ( .A1(FIFO_MEM_2[1]), .A2(n68), .B1(FIFO_MEM_1[1]), .B2(n71), 
        .Q(n45) );
  AOI22X1 U197 ( .A1(FIFO_MEM_4[1]), .A2(n74), .B1(FIFO_MEM_3[1]), .B2(n73), 
        .Q(n44) );
  NAND2XL U198 ( .A(n45), .B(n44), .Q(Data_out[1]) );
  AOI22X1 U199 ( .A1(FIFO_MEM_2[11]), .A2(n68), .B1(FIFO_MEM_1[11]), .B2(n71), 
        .Q(n47) );
  AOI22X1 U200 ( .A1(FIFO_MEM_4[11]), .A2(n74), .B1(FIFO_MEM_3[11]), .B2(n73), 
        .Q(n46) );
  NAND2XL U201 ( .A(n47), .B(n46), .Q(Data_out[11]) );
  AOI22X1 U202 ( .A1(FIFO_MEM_2[24]), .A2(n68), .B1(FIFO_MEM_1[24]), .B2(n71), 
        .Q(n49) );
  AOI22X1 U203 ( .A1(FIFO_MEM_4[24]), .A2(n74), .B1(FIFO_MEM_3[24]), .B2(n73), 
        .Q(n48) );
  NAND2XL U204 ( .A(n49), .B(n48), .Q(Data_out[24]) );
  AOI22X1 U205 ( .A1(FIFO_MEM_2[27]), .A2(n68), .B1(FIFO_MEM_1[27]), .B2(n71), 
        .Q(n51) );
  AOI22X1 U206 ( .A1(FIFO_MEM_4[27]), .A2(n74), .B1(FIFO_MEM_3[27]), .B2(n73), 
        .Q(n50) );
  NAND2XL U207 ( .A(n51), .B(n50), .Q(Data_out[27]) );
  AOI22X1 U208 ( .A1(FIFO_MEM_2[20]), .A2(n72), .B1(FIFO_MEM_1[20]), .B2(n71), 
        .Q(n53) );
  AOI22X1 U209 ( .A1(FIFO_MEM_4[20]), .A2(n74), .B1(FIFO_MEM_3[20]), .B2(n73), 
        .Q(n52) );
  NAND2XL U210 ( .A(n53), .B(n52), .Q(Data_out[20]) );
  AOI22X1 U211 ( .A1(FIFO_MEM_2[18]), .A2(n68), .B1(FIFO_MEM_1[18]), .B2(n71), 
        .Q(n55) );
  AOI22X1 U212 ( .A1(FIFO_MEM_4[18]), .A2(n74), .B1(FIFO_MEM_3[18]), .B2(n73), 
        .Q(n54) );
  NAND2XL U213 ( .A(n55), .B(n54), .Q(Data_out[18]) );
  AOI22X1 U214 ( .A1(FIFO_MEM_2[25]), .A2(n68), .B1(FIFO_MEM_1[25]), .B2(n71), 
        .Q(n57) );
  AOI22X1 U215 ( .A1(FIFO_MEM_4[25]), .A2(n74), .B1(FIFO_MEM_3[25]), .B2(n73), 
        .Q(n56) );
  NAND2XL U216 ( .A(n57), .B(n56), .Q(Data_out[25]) );
  AOI22X1 U217 ( .A1(FIFO_MEM_2[17]), .A2(n68), .B1(FIFO_MEM_1[17]), .B2(n71), 
        .Q(n59) );
  AOI22X1 U218 ( .A1(FIFO_MEM_4[17]), .A2(n74), .B1(FIFO_MEM_3[17]), .B2(n73), 
        .Q(n58) );
  NAND2XL U219 ( .A(n59), .B(n58), .Q(Data_out[17]) );
  AOI22X1 U220 ( .A1(FIFO_MEM_2[19]), .A2(n72), .B1(FIFO_MEM_1[19]), .B2(n71), 
        .Q(n61) );
  AOI22X1 U221 ( .A1(FIFO_MEM_4[19]), .A2(n74), .B1(FIFO_MEM_3[19]), .B2(n73), 
        .Q(n60) );
  NAND2XL U222 ( .A(n61), .B(n60), .Q(Data_out[19]) );
  AOI22X1 U223 ( .A1(FIFO_MEM_2[22]), .A2(n72), .B1(FIFO_MEM_1[22]), .B2(n71), 
        .Q(n63) );
  AOI22X1 U224 ( .A1(FIFO_MEM_4[22]), .A2(n74), .B1(FIFO_MEM_3[22]), .B2(n73), 
        .Q(n62) );
  NAND2XL U225 ( .A(n63), .B(n62), .Q(Data_out[22]) );
  AOI22X1 U226 ( .A1(FIFO_MEM_2[21]), .A2(n72), .B1(FIFO_MEM_1[21]), .B2(n71), 
        .Q(n65) );
  AOI22X1 U227 ( .A1(FIFO_MEM_4[21]), .A2(n74), .B1(FIFO_MEM_3[21]), .B2(n73), 
        .Q(n64) );
  NAND2XL U228 ( .A(n65), .B(n64), .Q(Data_out[21]) );
  AOI22X1 U229 ( .A1(FIFO_MEM_2[26]), .A2(n68), .B1(FIFO_MEM_1[26]), .B2(n71), 
        .Q(n67) );
  AOI22X1 U230 ( .A1(FIFO_MEM_4[26]), .A2(n74), .B1(FIFO_MEM_3[26]), .B2(n73), 
        .Q(n66) );
  NAND2XL U231 ( .A(n67), .B(n66), .Q(Data_out[26]) );
  AOI22X1 U232 ( .A1(FIFO_MEM_2[28]), .A2(n68), .B1(FIFO_MEM_1[28]), .B2(n71), 
        .Q(n70) );
  AOI22X1 U233 ( .A1(FIFO_MEM_4[28]), .A2(n74), .B1(FIFO_MEM_3[28]), .B2(n73), 
        .Q(n69) );
  NAND2XL U234 ( .A(n70), .B(n69), .Q(Data_out[28]) );
  AOI22X1 U235 ( .A1(FIFO_MEM_2[23]), .A2(n72), .B1(FIFO_MEM_1[23]), .B2(n71), 
        .Q(n76) );
  AOI22X1 U236 ( .A1(FIFO_MEM_4[23]), .A2(n74), .B1(FIFO_MEM_3[23]), .B2(n73), 
        .Q(n75) );
  NAND2XL U237 ( .A(n76), .B(n75), .Q(Data_out[23]) );
  AOI22X1 U238 ( .A1(n104), .A2(read_pointer[1]), .B1(n100), .B2(
        read_pointer[0]), .Q(n77) );
  OAI221X1 U239 ( .A1(n104), .A2(read_pointer[1]), .B1(n100), .B2(
        read_pointer[0]), .C1(n77), .Q(n78) );
  AO21X1 U240 ( .A1(write_pointer[1]), .A2(n95), .B1(n84), .Q(
        write_pointer_in[1]) );
  NOR2XL U241 ( .A(write_pointer[2]), .B(write_pointer[1]), .Q(n85) );
  NAND3X1 U242 ( .A(write_pointer[3]), .B(n85), .C(n104), .Q(n81) );
  AO22X2 U243 ( .A1(n86), .A2(RX[19]), .B1(n1), .B2(FIFO_MEM_1[19]), .Q(n121)
         );
  AO22X2 U244 ( .A1(n86), .A2(RX[18]), .B1(n1), .B2(FIFO_MEM_1[18]), .Q(n122)
         );
  AO22X2 U245 ( .A1(n86), .A2(RX[17]), .B1(n1), .B2(FIFO_MEM_1[17]), .Q(n123)
         );
  AO22X2 U246 ( .A1(n86), .A2(RX[16]), .B1(n1), .B2(FIFO_MEM_1[16]), .Q(n124)
         );
  AO22X2 U247 ( .A1(n86), .A2(RX[15]), .B1(n1), .B2(FIFO_MEM_1[15]), .Q(n125)
         );
  AO22X2 U248 ( .A1(n86), .A2(RX[23]), .B1(n1), .B2(FIFO_MEM_1[23]), .Q(n117)
         );
  AO22X2 U249 ( .A1(n86), .A2(RX[22]), .B1(n1), .B2(FIFO_MEM_1[22]), .Q(n118)
         );
  AO22X2 U250 ( .A1(n86), .A2(RX[21]), .B1(n1), .B2(FIFO_MEM_1[21]), .Q(n119)
         );
  AO22X2 U251 ( .A1(n86), .A2(RX[20]), .B1(n1), .B2(FIFO_MEM_1[20]), .Q(n120)
         );
  AO22X2 U252 ( .A1(n86), .A2(RX[27]), .B1(n1), .B2(FIFO_MEM_1[27]), .Q(n113)
         );
  AO22X2 U253 ( .A1(n86), .A2(RX[26]), .B1(n1), .B2(FIFO_MEM_1[26]), .Q(n114)
         );
  AO22X2 U254 ( .A1(n86), .A2(RX[25]), .B1(n1), .B2(FIFO_MEM_1[25]), .Q(n115)
         );
  AO22X2 U255 ( .A1(n86), .A2(RX[24]), .B1(n1), .B2(FIFO_MEM_1[24]), .Q(n116)
         );
  AO22X2 U256 ( .A1(n86), .A2(RX[28]), .B1(n1), .B2(FIFO_MEM_1[28]), .Q(n112)
         );
  AO22X2 U257 ( .A1(n86), .A2(RX[29]), .B1(n1), .B2(FIFO_MEM_1[29]), .Q(n111)
         );
  NOR2XL U258 ( .A(write_pointer[3]), .B(write_pointer[0]), .Q(n88) );
  NAND3X1 U259 ( .A(n102), .B(write_pointer[1]), .C(n88), .Q(n87) );
  NAND3X1 U260 ( .A(write_pointer[2]), .B(n88), .C(n98), .Q(n89) );
  AOI22X1 U261 ( .A1(read_en), .A2(n97), .B1(n103), .B2(n94), .Q(
        read_pointer_in[0]) );
  AOI22X1 U262 ( .A1(read_en), .A2(n103), .B1(n99), .B2(n94), .Q(
        read_pointer_in[1]) );
  AOI22X1 U263 ( .A1(read_en), .A2(n99), .B1(n101), .B2(n94), .Q(
        read_pointer_in[2]) );
  AOI22X1 U264 ( .A1(read_en), .A2(n101), .B1(n97), .B2(n94), .Q(
        read_pointer_in[3]) );
  INVXL U265 ( .A(n95), .Q(n96) );
  AOI22X1 U266 ( .A1(n96), .A2(n100), .B1(n104), .B2(n95), .Q(
        write_pointer_in[0]) );
  AOI22X1 U267 ( .A1(n96), .A2(n98), .B1(n102), .B2(n95), .Q(
        write_pointer_in[2]) );
  AOI22X1 U268 ( .A1(n96), .A2(n102), .B1(n100), .B2(n95), .Q(
        write_pointer_in[3]) );
endmodule


module FIFO_credit_based_DATA_WIDTH32_1 ( reset, clk, RX, valid_in, read_en_N, 
        read_en_E, read_en_W, read_en_S, read_en_L, credit_out, empty_out, 
        Data_out );
  input [31:0] RX;
  output [31:0] Data_out;
  input reset, clk, valid_in, read_en_N, read_en_E, read_en_W, read_en_S,
         read_en_L;
  output credit_out, empty_out;
  wire   read_en, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103;
  wire   [3:0] read_pointer;
  wire   [3:0] write_pointer;
  wire   [31:0] FIFO_MEM_1;
  wire   [31:0] FIFO_MEM_2;
  wire   [31:0] FIFO_MEM_3;
  wire   [31:0] FIFO_MEM_4;
  wire   [3:0] write_pointer_in;
  wire   [3:0] read_pointer_in;

  DFPX1 \write_pointer_reg[0]  ( .D(write_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(write_pointer[0]), .QN(n102) );
  DFCX1 \write_pointer_reg[1]  ( .D(write_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(write_pointer[1]), .QN(n99) );
  DFCX1 \write_pointer_reg[2]  ( .D(write_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(write_pointer[2]), .QN(n101) );
  DFCX1 \write_pointer_reg[3]  ( .D(write_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(write_pointer[3]), .QN(n96) );
  DFCX1 \read_pointer_reg[3]  ( .D(read_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(read_pointer[3]), .QN(n98) );
  DFCX1 \read_pointer_reg[1]  ( .D(read_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(read_pointer[1]), .QN(n100) );
  DFCX1 \read_pointer_reg[2]  ( .D(read_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(read_pointer[2]), .QN(n97) );
  DFCX1 \FIFO_MEM_1_reg[31]  ( .D(n109), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[31]) );
  DFCX1 \FIFO_MEM_1_reg[30]  ( .D(n110), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[30]) );
  DFCX1 \FIFO_MEM_1_reg[29]  ( .D(n111), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[29]) );
  DFCX1 \FIFO_MEM_1_reg[28]  ( .D(n112), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[28]) );
  DFCX1 \FIFO_MEM_1_reg[27]  ( .D(n113), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[27]) );
  DFCX1 \FIFO_MEM_1_reg[26]  ( .D(n114), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[26]) );
  DFCX1 \FIFO_MEM_1_reg[25]  ( .D(n115), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[25]) );
  DFCX1 \FIFO_MEM_1_reg[24]  ( .D(n116), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[24]) );
  DFCX1 \FIFO_MEM_1_reg[23]  ( .D(n117), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[23]) );
  DFCX1 \FIFO_MEM_1_reg[22]  ( .D(n118), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[22]) );
  DFCX1 \FIFO_MEM_1_reg[21]  ( .D(n119), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[21]) );
  DFCX1 \FIFO_MEM_1_reg[20]  ( .D(n120), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[20]) );
  DFCX1 \FIFO_MEM_1_reg[19]  ( .D(n121), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[19]) );
  DFCX1 \FIFO_MEM_1_reg[18]  ( .D(n122), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[18]) );
  DFCX1 \FIFO_MEM_1_reg[17]  ( .D(n123), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[17]) );
  DFCX1 \FIFO_MEM_1_reg[16]  ( .D(n124), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[16]) );
  DFCX1 \FIFO_MEM_1_reg[15]  ( .D(n125), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[15]) );
  DFCX1 \FIFO_MEM_1_reg[14]  ( .D(n126), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[14]) );
  DFCX1 \FIFO_MEM_1_reg[13]  ( .D(n127), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[13]) );
  DFCX1 \FIFO_MEM_1_reg[12]  ( .D(n128), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[12]) );
  DFCX1 \FIFO_MEM_1_reg[11]  ( .D(n129), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[11]) );
  DFCX1 \FIFO_MEM_1_reg[10]  ( .D(n130), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[10]) );
  DFCX1 \FIFO_MEM_1_reg[9]  ( .D(n131), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[9]) );
  DFCX1 \FIFO_MEM_1_reg[8]  ( .D(n132), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[8]) );
  DFCX1 \FIFO_MEM_1_reg[7]  ( .D(n133), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[7]) );
  DFCX1 \FIFO_MEM_1_reg[6]  ( .D(n134), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[6]) );
  DFCX1 \FIFO_MEM_1_reg[5]  ( .D(n135), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[5]) );
  DFCX1 \FIFO_MEM_1_reg[4]  ( .D(n136), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[4]) );
  DFCX1 \FIFO_MEM_1_reg[3]  ( .D(n137), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[3]) );
  DFCX1 \FIFO_MEM_1_reg[2]  ( .D(n138), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[2]) );
  DFCX1 \FIFO_MEM_1_reg[1]  ( .D(n139), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[1]) );
  DFCX1 \FIFO_MEM_1_reg[0]  ( .D(n140), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[0]) );
  DFCX1 \FIFO_MEM_2_reg[31]  ( .D(n141), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[31]) );
  DFCX1 \FIFO_MEM_2_reg[30]  ( .D(n142), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[30]) );
  DFCX1 \FIFO_MEM_2_reg[29]  ( .D(n143), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[29]) );
  DFCX1 \FIFO_MEM_2_reg[28]  ( .D(n144), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[28]) );
  DFCX1 \FIFO_MEM_2_reg[27]  ( .D(n145), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[27]) );
  DFCX1 \FIFO_MEM_2_reg[26]  ( .D(n146), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[26]) );
  DFCX1 \FIFO_MEM_2_reg[25]  ( .D(n147), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[25]) );
  DFCX1 \FIFO_MEM_2_reg[24]  ( .D(n148), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[24]) );
  DFCX1 \FIFO_MEM_2_reg[23]  ( .D(n149), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[23]) );
  DFCX1 \FIFO_MEM_2_reg[22]  ( .D(n150), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[22]) );
  DFCX1 \FIFO_MEM_2_reg[21]  ( .D(n151), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[21]) );
  DFCX1 \FIFO_MEM_2_reg[20]  ( .D(n152), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[20]) );
  DFCX1 \FIFO_MEM_2_reg[19]  ( .D(n153), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[19]) );
  DFCX1 \FIFO_MEM_2_reg[18]  ( .D(n154), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[18]) );
  DFCX1 \FIFO_MEM_2_reg[17]  ( .D(n155), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[17]) );
  DFCX1 \FIFO_MEM_2_reg[16]  ( .D(n156), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[16]) );
  DFCX1 \FIFO_MEM_2_reg[15]  ( .D(n157), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[15]) );
  DFCX1 \FIFO_MEM_2_reg[14]  ( .D(n158), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[14]) );
  DFCX1 \FIFO_MEM_2_reg[13]  ( .D(n159), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[13]) );
  DFCX1 \FIFO_MEM_2_reg[12]  ( .D(n160), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[12]) );
  DFCX1 \FIFO_MEM_2_reg[11]  ( .D(n161), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[11]) );
  DFCX1 \FIFO_MEM_2_reg[10]  ( .D(n162), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[10]) );
  DFCX1 \FIFO_MEM_2_reg[9]  ( .D(n163), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[9]) );
  DFCX1 \FIFO_MEM_2_reg[8]  ( .D(n164), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[8]) );
  DFCX1 \FIFO_MEM_2_reg[7]  ( .D(n165), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[7]) );
  DFCX1 \FIFO_MEM_2_reg[6]  ( .D(n166), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[6]) );
  DFCX1 \FIFO_MEM_2_reg[5]  ( .D(n167), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[5]) );
  DFCX1 \FIFO_MEM_2_reg[4]  ( .D(n168), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[4]) );
  DFCX1 \FIFO_MEM_2_reg[3]  ( .D(n169), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[3]) );
  DFCX1 \FIFO_MEM_2_reg[2]  ( .D(n170), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[2]) );
  DFCX1 \FIFO_MEM_2_reg[1]  ( .D(n171), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[1]) );
  DFCX1 \FIFO_MEM_2_reg[0]  ( .D(n172), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[0]) );
  DFCX1 \FIFO_MEM_3_reg[31]  ( .D(n173), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[31]) );
  DFCX1 \FIFO_MEM_3_reg[30]  ( .D(n174), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[30]) );
  DFCX1 \FIFO_MEM_3_reg[29]  ( .D(n175), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[29]) );
  DFCX1 \FIFO_MEM_3_reg[28]  ( .D(n176), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[28]) );
  DFCX1 \FIFO_MEM_3_reg[27]  ( .D(n177), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[27]) );
  DFCX1 \FIFO_MEM_3_reg[26]  ( .D(n178), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[26]) );
  DFCX1 \FIFO_MEM_3_reg[25]  ( .D(n179), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[25]) );
  DFCX1 \FIFO_MEM_3_reg[24]  ( .D(n180), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[24]) );
  DFCX1 \FIFO_MEM_3_reg[23]  ( .D(n181), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[23]) );
  DFCX1 \FIFO_MEM_3_reg[22]  ( .D(n182), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[22]) );
  DFCX1 \FIFO_MEM_3_reg[21]  ( .D(n183), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[21]) );
  DFCX1 \FIFO_MEM_3_reg[20]  ( .D(n184), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[20]) );
  DFCX1 \FIFO_MEM_3_reg[19]  ( .D(n185), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[19]) );
  DFCX1 \FIFO_MEM_3_reg[18]  ( .D(n186), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[18]) );
  DFCX1 \FIFO_MEM_3_reg[17]  ( .D(n187), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[17]) );
  DFCX1 \FIFO_MEM_3_reg[16]  ( .D(n188), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[16]) );
  DFCX1 \FIFO_MEM_3_reg[15]  ( .D(n189), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[15]) );
  DFCX1 \FIFO_MEM_3_reg[14]  ( .D(n190), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[14]) );
  DFCX1 \FIFO_MEM_3_reg[13]  ( .D(n191), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[13]) );
  DFCX1 \FIFO_MEM_3_reg[12]  ( .D(n192), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[12]) );
  DFCX1 \FIFO_MEM_3_reg[11]  ( .D(n193), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[11]) );
  DFCX1 \FIFO_MEM_3_reg[10]  ( .D(n194), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[10]) );
  DFCX1 \FIFO_MEM_3_reg[9]  ( .D(n195), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[9]) );
  DFCX1 \FIFO_MEM_3_reg[8]  ( .D(n196), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[8]) );
  DFCX1 \FIFO_MEM_3_reg[7]  ( .D(n197), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[7]) );
  DFCX1 \FIFO_MEM_3_reg[6]  ( .D(n198), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[6]) );
  DFCX1 \FIFO_MEM_3_reg[5]  ( .D(n199), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[5]) );
  DFCX1 \FIFO_MEM_3_reg[4]  ( .D(n200), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[4]) );
  DFCX1 \FIFO_MEM_3_reg[3]  ( .D(n201), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[3]) );
  DFCX1 \FIFO_MEM_3_reg[2]  ( .D(n202), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[2]) );
  DFCX1 \FIFO_MEM_3_reg[1]  ( .D(n203), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[1]) );
  DFCX1 \FIFO_MEM_3_reg[0]  ( .D(n204), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[0]) );
  DFCX1 \FIFO_MEM_4_reg[31]  ( .D(n205), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[31]) );
  DFCX1 \FIFO_MEM_4_reg[30]  ( .D(n206), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[30]) );
  DFCX1 \FIFO_MEM_4_reg[29]  ( .D(n207), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[29]) );
  DFCX1 \FIFO_MEM_4_reg[28]  ( .D(n208), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[28]) );
  DFCX1 \FIFO_MEM_4_reg[27]  ( .D(n209), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[27]) );
  DFCX1 \FIFO_MEM_4_reg[26]  ( .D(n210), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[26]) );
  DFCX1 \FIFO_MEM_4_reg[25]  ( .D(n211), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[25]) );
  DFCX1 \FIFO_MEM_4_reg[24]  ( .D(n212), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[24]) );
  DFCX1 \FIFO_MEM_4_reg[23]  ( .D(n213), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[23]) );
  DFCX1 \FIFO_MEM_4_reg[22]  ( .D(n214), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[22]) );
  DFCX1 \FIFO_MEM_4_reg[21]  ( .D(n215), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[21]) );
  DFCX1 \FIFO_MEM_4_reg[20]  ( .D(n216), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[20]) );
  DFCX1 \FIFO_MEM_4_reg[19]  ( .D(n217), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[19]) );
  DFCX1 \FIFO_MEM_4_reg[18]  ( .D(n218), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[18]) );
  DFCX1 \FIFO_MEM_4_reg[17]  ( .D(n219), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[17]) );
  DFCX1 \FIFO_MEM_4_reg[16]  ( .D(n220), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[16]) );
  DFCX1 \FIFO_MEM_4_reg[15]  ( .D(n221), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[15]) );
  DFCX1 \FIFO_MEM_4_reg[14]  ( .D(n222), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[14]) );
  DFCX1 \FIFO_MEM_4_reg[13]  ( .D(n223), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[13]) );
  DFCX1 \FIFO_MEM_4_reg[12]  ( .D(n224), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[12]) );
  DFCX1 \FIFO_MEM_4_reg[11]  ( .D(n225), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[11]) );
  DFCX1 \FIFO_MEM_4_reg[10]  ( .D(n226), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[10]) );
  DFCX1 \FIFO_MEM_4_reg[9]  ( .D(n227), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[9]) );
  DFCX1 \FIFO_MEM_4_reg[8]  ( .D(n228), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[8]) );
  DFCX1 \FIFO_MEM_4_reg[7]  ( .D(n229), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[7]) );
  DFCX1 \FIFO_MEM_4_reg[6]  ( .D(n230), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[6]) );
  DFCX1 \FIFO_MEM_4_reg[5]  ( .D(n231), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[5]) );
  DFCX1 \FIFO_MEM_4_reg[4]  ( .D(n232), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[4]) );
  DFCX1 \FIFO_MEM_4_reg[3]  ( .D(n233), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[3]) );
  DFCX1 \FIFO_MEM_4_reg[2]  ( .D(n234), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[2]) );
  DFCX1 \FIFO_MEM_4_reg[1]  ( .D(n235), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[1]) );
  DFCX1 \FIFO_MEM_4_reg[0]  ( .D(n236), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[0]) );
  DFCX1 credit_out_reg ( .D(read_en), .CP(clk), .RN(reset), .Q(credit_out) );
  DFPX1 \read_pointer_reg[0]  ( .D(read_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(read_pointer[0]), .QN(n103) );
  AND3X2 U3 ( .A(n84), .B(n83), .C(n96), .Q(n85) );
  NOR3X3 U4 ( .A(n72), .B(n73), .C(n71), .Q(n13) );
  OAI221X1 U5 ( .A1(write_pointer[2]), .A2(n98), .B1(n101), .B2(
        read_pointer[3]), .C1(n78), .Q(n79) );
  CLKINVX2 U6 ( .A(n85), .Q(n1) );
  NAND2X3 U7 ( .A(valid_in), .B(n79), .Q(n94) );
  AOI221X2 U8 ( .A1(write_pointer[1]), .A2(n97), .B1(n99), .B2(read_pointer[2]), .C1(n77), .Q(n78) );
  NOR4X2 U9 ( .A(read_en_N), .B(read_en_E), .C(read_en_W), .D(read_en_L), .Q(
        n5) );
  AO22X2 U10 ( .A1(n85), .A2(RX[12]), .B1(n1), .B2(FIFO_MEM_1[12]), .Q(n128)
         );
  AO22X2 U11 ( .A1(n85), .A2(RX[13]), .B1(n1), .B2(FIFO_MEM_1[13]), .Q(n127)
         );
  AO22X2 U12 ( .A1(n85), .A2(RX[14]), .B1(n1), .B2(FIFO_MEM_1[14]), .Q(n126)
         );
  AO22X2 U13 ( .A1(n85), .A2(RX[4]), .B1(n1), .B2(FIFO_MEM_1[4]), .Q(n136) );
  AO22X2 U14 ( .A1(n85), .A2(RX[7]), .B1(n1), .B2(FIFO_MEM_1[7]), .Q(n133) );
  AO22X2 U15 ( .A1(n85), .A2(RX[3]), .B1(n1), .B2(FIFO_MEM_1[3]), .Q(n137) );
  AO22X2 U16 ( .A1(n85), .A2(RX[10]), .B1(n1), .B2(FIFO_MEM_1[10]), .Q(n130)
         );
  AO22X2 U17 ( .A1(n85), .A2(RX[2]), .B1(n1), .B2(FIFO_MEM_1[2]), .Q(n138) );
  AO22X2 U18 ( .A1(n85), .A2(RX[8]), .B1(n1), .B2(FIFO_MEM_1[8]), .Q(n132) );
  AO22X2 U19 ( .A1(n85), .A2(RX[11]), .B1(n1), .B2(FIFO_MEM_1[11]), .Q(n129)
         );
  AO22X2 U20 ( .A1(n85), .A2(RX[1]), .B1(n1), .B2(FIFO_MEM_1[1]), .Q(n139) );
  AO22X2 U21 ( .A1(n85), .A2(RX[9]), .B1(n1), .B2(FIFO_MEM_1[9]), .Q(n131) );
  AO22X2 U22 ( .A1(n85), .A2(RX[6]), .B1(n1), .B2(FIFO_MEM_1[6]), .Q(n134) );
  AO22X2 U23 ( .A1(n85), .A2(RX[0]), .B1(n1), .B2(FIFO_MEM_1[0]), .Q(n140) );
  AO22X2 U24 ( .A1(n85), .A2(RX[5]), .B1(n1), .B2(FIFO_MEM_1[5]), .Q(n135) );
  NAND2X2 U25 ( .A(n103), .B(n100), .Q(n6) );
  NAND2XL U26 ( .A(n8), .B(n7), .Q(Data_out[29]) );
  AOI22X1 U27 ( .A1(FIFO_MEM_2[29]), .A2(n71), .B1(FIFO_MEM_1[29]), .B2(n70), 
        .Q(n8) );
  NOR2X3 U28 ( .A(n94), .B(n80), .Q(n82) );
  NOR2X3 U29 ( .A(n88), .B(n94), .Q(n92) );
  NOR2X3 U30 ( .A(n86), .B(n94), .Q(n90) );
  NOR2XL U31 ( .A(n102), .B(n94), .Q(n83) );
  AOI221X1 U32 ( .A1(n99), .A2(read_pointer[1]), .B1(write_pointer[0]), .B2(
        n103), .C1(n2), .Q(n3) );
  OAI22X1 U33 ( .A1(n99), .A2(read_pointer[1]), .B1(n103), .B2(
        write_pointer[0]), .Q(n2) );
  CLKINVX2 U34 ( .A(n82), .Q(n81) );
  CLKINVX2 U35 ( .A(n92), .Q(n91) );
  CLKINVX2 U36 ( .A(n90), .Q(n89) );
  AO22X1 U37 ( .A1(n82), .A2(RX[0]), .B1(FIFO_MEM_4[0]), .B2(n81), .Q(n236) );
  AO22X1 U38 ( .A1(RX[1]), .A2(n82), .B1(FIFO_MEM_4[1]), .B2(n81), .Q(n235) );
  AO22X1 U39 ( .A1(RX[2]), .A2(n82), .B1(FIFO_MEM_4[2]), .B2(n81), .Q(n234) );
  AO22X1 U40 ( .A1(RX[3]), .A2(n82), .B1(FIFO_MEM_4[3]), .B2(n81), .Q(n233) );
  AO22X1 U41 ( .A1(RX[4]), .A2(n82), .B1(FIFO_MEM_4[4]), .B2(n81), .Q(n232) );
  AO22X1 U42 ( .A1(RX[5]), .A2(n82), .B1(FIFO_MEM_4[5]), .B2(n81), .Q(n231) );
  AO22X1 U43 ( .A1(RX[6]), .A2(n82), .B1(FIFO_MEM_4[6]), .B2(n81), .Q(n230) );
  AO22X1 U44 ( .A1(RX[7]), .A2(n82), .B1(FIFO_MEM_4[7]), .B2(n81), .Q(n229) );
  AO22X1 U45 ( .A1(RX[8]), .A2(n82), .B1(FIFO_MEM_4[8]), .B2(n81), .Q(n228) );
  AO22X1 U46 ( .A1(RX[9]), .A2(n82), .B1(FIFO_MEM_4[9]), .B2(n81), .Q(n227) );
  AO22X1 U47 ( .A1(RX[10]), .A2(n82), .B1(FIFO_MEM_4[10]), .B2(n81), .Q(n226)
         );
  AO22X1 U48 ( .A1(RX[11]), .A2(n82), .B1(FIFO_MEM_4[11]), .B2(n81), .Q(n225)
         );
  AO22X1 U49 ( .A1(RX[12]), .A2(n82), .B1(FIFO_MEM_4[12]), .B2(n81), .Q(n224)
         );
  AO22X1 U50 ( .A1(RX[13]), .A2(n82), .B1(FIFO_MEM_4[13]), .B2(n81), .Q(n223)
         );
  AO22X1 U51 ( .A1(RX[14]), .A2(n82), .B1(FIFO_MEM_4[14]), .B2(n81), .Q(n222)
         );
  AO22X1 U52 ( .A1(RX[15]), .A2(n82), .B1(FIFO_MEM_4[15]), .B2(n81), .Q(n221)
         );
  AO22X1 U53 ( .A1(RX[16]), .A2(n82), .B1(FIFO_MEM_4[16]), .B2(n81), .Q(n220)
         );
  AO22X1 U54 ( .A1(RX[17]), .A2(n82), .B1(FIFO_MEM_4[17]), .B2(n81), .Q(n219)
         );
  AO22X1 U55 ( .A1(RX[18]), .A2(n82), .B1(FIFO_MEM_4[18]), .B2(n81), .Q(n218)
         );
  AO22X1 U56 ( .A1(RX[19]), .A2(n82), .B1(FIFO_MEM_4[19]), .B2(n81), .Q(n217)
         );
  AO22X1 U57 ( .A1(RX[20]), .A2(n82), .B1(FIFO_MEM_4[20]), .B2(n81), .Q(n216)
         );
  AO22X1 U58 ( .A1(RX[21]), .A2(n82), .B1(FIFO_MEM_4[21]), .B2(n81), .Q(n215)
         );
  AO22X1 U59 ( .A1(RX[22]), .A2(n82), .B1(FIFO_MEM_4[22]), .B2(n81), .Q(n214)
         );
  AO22X1 U60 ( .A1(RX[23]), .A2(n82), .B1(FIFO_MEM_4[23]), .B2(n81), .Q(n213)
         );
  AO22X1 U61 ( .A1(RX[24]), .A2(n82), .B1(FIFO_MEM_4[24]), .B2(n81), .Q(n212)
         );
  AO22X1 U62 ( .A1(RX[25]), .A2(n82), .B1(FIFO_MEM_4[25]), .B2(n81), .Q(n211)
         );
  AO22X1 U63 ( .A1(RX[26]), .A2(n82), .B1(FIFO_MEM_4[26]), .B2(n81), .Q(n210)
         );
  AO22X1 U64 ( .A1(RX[27]), .A2(n82), .B1(FIFO_MEM_4[27]), .B2(n81), .Q(n209)
         );
  AO22X1 U65 ( .A1(RX[28]), .A2(n82), .B1(FIFO_MEM_4[28]), .B2(n81), .Q(n208)
         );
  AO22X1 U66 ( .A1(RX[29]), .A2(n82), .B1(FIFO_MEM_4[29]), .B2(n81), .Q(n207)
         );
  AO22X1 U67 ( .A1(RX[30]), .A2(n82), .B1(FIFO_MEM_4[30]), .B2(n81), .Q(n206)
         );
  AO22X1 U68 ( .A1(RX[31]), .A2(n82), .B1(FIFO_MEM_4[31]), .B2(n81), .Q(n205)
         );
  AO22X1 U69 ( .A1(RX[0]), .A2(n92), .B1(FIFO_MEM_3[0]), .B2(n91), .Q(n204) );
  AO22X1 U70 ( .A1(RX[1]), .A2(n92), .B1(FIFO_MEM_3[1]), .B2(n91), .Q(n203) );
  AO22X1 U71 ( .A1(RX[2]), .A2(n92), .B1(FIFO_MEM_3[2]), .B2(n91), .Q(n202) );
  AO22X1 U72 ( .A1(RX[3]), .A2(n92), .B1(FIFO_MEM_3[3]), .B2(n91), .Q(n201) );
  AO22X1 U73 ( .A1(RX[4]), .A2(n92), .B1(FIFO_MEM_3[4]), .B2(n91), .Q(n200) );
  AO22X1 U74 ( .A1(RX[5]), .A2(n92), .B1(FIFO_MEM_3[5]), .B2(n91), .Q(n199) );
  AO22X1 U75 ( .A1(RX[6]), .A2(n92), .B1(FIFO_MEM_3[6]), .B2(n91), .Q(n198) );
  AO22X1 U76 ( .A1(RX[7]), .A2(n92), .B1(FIFO_MEM_3[7]), .B2(n91), .Q(n197) );
  AO22X1 U77 ( .A1(RX[8]), .A2(n92), .B1(FIFO_MEM_3[8]), .B2(n91), .Q(n196) );
  AO22X1 U78 ( .A1(RX[9]), .A2(n92), .B1(FIFO_MEM_3[9]), .B2(n91), .Q(n195) );
  AO22X1 U79 ( .A1(RX[10]), .A2(n92), .B1(FIFO_MEM_3[10]), .B2(n91), .Q(n194)
         );
  AO22X1 U80 ( .A1(RX[11]), .A2(n92), .B1(FIFO_MEM_3[11]), .B2(n91), .Q(n193)
         );
  AO22X1 U81 ( .A1(RX[12]), .A2(n92), .B1(FIFO_MEM_3[12]), .B2(n91), .Q(n192)
         );
  AO22X1 U82 ( .A1(RX[13]), .A2(n92), .B1(FIFO_MEM_3[13]), .B2(n91), .Q(n191)
         );
  AO22X1 U83 ( .A1(RX[14]), .A2(n92), .B1(FIFO_MEM_3[14]), .B2(n91), .Q(n190)
         );
  AO22X1 U84 ( .A1(RX[15]), .A2(n92), .B1(FIFO_MEM_3[15]), .B2(n91), .Q(n189)
         );
  AO22X1 U85 ( .A1(RX[16]), .A2(n92), .B1(FIFO_MEM_3[16]), .B2(n91), .Q(n188)
         );
  AO22X1 U86 ( .A1(RX[17]), .A2(n92), .B1(FIFO_MEM_3[17]), .B2(n91), .Q(n187)
         );
  AO22X1 U87 ( .A1(RX[18]), .A2(n92), .B1(FIFO_MEM_3[18]), .B2(n91), .Q(n186)
         );
  AO22X1 U88 ( .A1(RX[19]), .A2(n92), .B1(FIFO_MEM_3[19]), .B2(n91), .Q(n185)
         );
  AO22X1 U89 ( .A1(RX[20]), .A2(n92), .B1(FIFO_MEM_3[20]), .B2(n91), .Q(n184)
         );
  AO22X1 U90 ( .A1(RX[21]), .A2(n92), .B1(FIFO_MEM_3[21]), .B2(n91), .Q(n183)
         );
  AO22X1 U91 ( .A1(RX[22]), .A2(n92), .B1(FIFO_MEM_3[22]), .B2(n91), .Q(n182)
         );
  AO22X1 U92 ( .A1(RX[23]), .A2(n92), .B1(FIFO_MEM_3[23]), .B2(n91), .Q(n181)
         );
  AO22X1 U93 ( .A1(RX[24]), .A2(n92), .B1(FIFO_MEM_3[24]), .B2(n91), .Q(n180)
         );
  AO22X1 U94 ( .A1(RX[25]), .A2(n92), .B1(FIFO_MEM_3[25]), .B2(n91), .Q(n179)
         );
  AO22X1 U95 ( .A1(RX[26]), .A2(n92), .B1(FIFO_MEM_3[26]), .B2(n91), .Q(n178)
         );
  AO22X1 U96 ( .A1(RX[27]), .A2(n92), .B1(FIFO_MEM_3[27]), .B2(n91), .Q(n177)
         );
  AO22X1 U97 ( .A1(RX[28]), .A2(n92), .B1(FIFO_MEM_3[28]), .B2(n91), .Q(n176)
         );
  AO22X1 U98 ( .A1(RX[29]), .A2(n92), .B1(FIFO_MEM_3[29]), .B2(n91), .Q(n175)
         );
  AO22X1 U99 ( .A1(RX[30]), .A2(n92), .B1(FIFO_MEM_3[30]), .B2(n91), .Q(n174)
         );
  AO22X1 U100 ( .A1(RX[31]), .A2(n92), .B1(FIFO_MEM_3[31]), .B2(n91), .Q(n173)
         );
  AO22X1 U101 ( .A1(RX[0]), .A2(n90), .B1(FIFO_MEM_2[0]), .B2(n89), .Q(n172)
         );
  AO22X1 U102 ( .A1(RX[1]), .A2(n90), .B1(FIFO_MEM_2[1]), .B2(n89), .Q(n171)
         );
  AO22X1 U103 ( .A1(RX[2]), .A2(n90), .B1(FIFO_MEM_2[2]), .B2(n89), .Q(n170)
         );
  AO22X1 U104 ( .A1(RX[3]), .A2(n90), .B1(FIFO_MEM_2[3]), .B2(n89), .Q(n169)
         );
  AO22X1 U105 ( .A1(RX[4]), .A2(n90), .B1(FIFO_MEM_2[4]), .B2(n89), .Q(n168)
         );
  AO22X1 U106 ( .A1(RX[5]), .A2(n90), .B1(FIFO_MEM_2[5]), .B2(n89), .Q(n167)
         );
  AO22X1 U107 ( .A1(RX[6]), .A2(n90), .B1(FIFO_MEM_2[6]), .B2(n89), .Q(n166)
         );
  AO22X1 U108 ( .A1(RX[7]), .A2(n90), .B1(FIFO_MEM_2[7]), .B2(n89), .Q(n165)
         );
  AO22X1 U109 ( .A1(RX[8]), .A2(n90), .B1(FIFO_MEM_2[8]), .B2(n89), .Q(n164)
         );
  AO22X1 U110 ( .A1(RX[9]), .A2(n90), .B1(FIFO_MEM_2[9]), .B2(n89), .Q(n163)
         );
  AO22X1 U111 ( .A1(RX[10]), .A2(n90), .B1(FIFO_MEM_2[10]), .B2(n89), .Q(n162)
         );
  AO22X1 U112 ( .A1(RX[11]), .A2(n90), .B1(FIFO_MEM_2[11]), .B2(n89), .Q(n161)
         );
  AO22X1 U113 ( .A1(RX[12]), .A2(n90), .B1(FIFO_MEM_2[12]), .B2(n89), .Q(n160)
         );
  AO22X1 U114 ( .A1(RX[13]), .A2(n90), .B1(FIFO_MEM_2[13]), .B2(n89), .Q(n159)
         );
  AO22X1 U115 ( .A1(RX[14]), .A2(n90), .B1(FIFO_MEM_2[14]), .B2(n89), .Q(n158)
         );
  AO22X1 U116 ( .A1(RX[15]), .A2(n90), .B1(FIFO_MEM_2[15]), .B2(n89), .Q(n157)
         );
  AO22X1 U117 ( .A1(RX[16]), .A2(n90), .B1(FIFO_MEM_2[16]), .B2(n89), .Q(n156)
         );
  AO22X1 U118 ( .A1(RX[17]), .A2(n90), .B1(FIFO_MEM_2[17]), .B2(n89), .Q(n155)
         );
  AO22X1 U119 ( .A1(RX[18]), .A2(n90), .B1(FIFO_MEM_2[18]), .B2(n89), .Q(n154)
         );
  AO22X1 U120 ( .A1(RX[19]), .A2(n90), .B1(FIFO_MEM_2[19]), .B2(n89), .Q(n153)
         );
  AO22X1 U121 ( .A1(RX[20]), .A2(n90), .B1(FIFO_MEM_2[20]), .B2(n89), .Q(n152)
         );
  AO22X1 U122 ( .A1(RX[21]), .A2(n90), .B1(FIFO_MEM_2[21]), .B2(n89), .Q(n151)
         );
  AO22X1 U123 ( .A1(RX[22]), .A2(n90), .B1(FIFO_MEM_2[22]), .B2(n89), .Q(n150)
         );
  AO22X1 U124 ( .A1(RX[23]), .A2(n90), .B1(FIFO_MEM_2[23]), .B2(n89), .Q(n149)
         );
  AO22X1 U125 ( .A1(RX[24]), .A2(n90), .B1(FIFO_MEM_2[24]), .B2(n89), .Q(n148)
         );
  AO22X1 U126 ( .A1(RX[25]), .A2(n90), .B1(FIFO_MEM_2[25]), .B2(n89), .Q(n147)
         );
  AO22X1 U127 ( .A1(RX[26]), .A2(n90), .B1(FIFO_MEM_2[26]), .B2(n89), .Q(n146)
         );
  AO22X1 U128 ( .A1(RX[27]), .A2(n90), .B1(FIFO_MEM_2[27]), .B2(n89), .Q(n145)
         );
  AO22X1 U129 ( .A1(RX[28]), .A2(n90), .B1(FIFO_MEM_2[28]), .B2(n89), .Q(n144)
         );
  AO22X1 U130 ( .A1(RX[29]), .A2(n90), .B1(FIFO_MEM_2[29]), .B2(n89), .Q(n143)
         );
  AO22X1 U131 ( .A1(RX[30]), .A2(n90), .B1(FIFO_MEM_2[30]), .B2(n89), .Q(n142)
         );
  AO22X1 U132 ( .A1(RX[31]), .A2(n90), .B1(FIFO_MEM_2[31]), .B2(n89), .Q(n141)
         );
  AO22X1 U133 ( .A1(n85), .A2(RX[30]), .B1(n1), .B2(FIFO_MEM_1[30]), .Q(n110)
         );
  AO22X1 U134 ( .A1(n85), .A2(RX[31]), .B1(n1), .B2(FIFO_MEM_1[31]), .Q(n109)
         );
  OAI221X1 U135 ( .A1(write_pointer[2]), .A2(n97), .B1(n101), .B2(
        read_pointer[2]), .C1(n3), .Q(n4) );
  AOI221X3 U136 ( .A1(write_pointer[3]), .A2(n98), .B1(n96), .B2(
        read_pointer[3]), .C1(n4), .Q(empty_out) );
  NOR2X3 U137 ( .A(empty_out), .B(n5), .Q(read_en) );
  NOR4X6 U138 ( .A(read_pointer[0]), .B(read_pointer[3]), .C(read_pointer[2]), 
        .D(n100), .Q(n71) );
  NOR3X3 U139 ( .A(read_pointer[3]), .B(n97), .C(n6), .Q(n72) );
  NOR3X3 U140 ( .A(read_pointer[2]), .B(n98), .C(n6), .Q(n73) );
  BUFX6 U141 ( .A(n13), .Q(n70) );
  AOI22X1 U142 ( .A1(FIFO_MEM_4[29]), .A2(n73), .B1(FIFO_MEM_3[29]), .B2(n72), 
        .Q(n7) );
  AOI22X1 U143 ( .A1(FIFO_MEM_2[30]), .A2(n71), .B1(FIFO_MEM_1[30]), .B2(n70), 
        .Q(n10) );
  AOI22X1 U144 ( .A1(FIFO_MEM_4[30]), .A2(n73), .B1(FIFO_MEM_3[30]), .B2(n72), 
        .Q(n9) );
  NAND2XL U145 ( .A(n10), .B(n9), .Q(Data_out[30]) );
  AOI22X1 U146 ( .A1(FIFO_MEM_2[16]), .A2(n71), .B1(FIFO_MEM_1[16]), .B2(n70), 
        .Q(n12) );
  AOI22X1 U147 ( .A1(FIFO_MEM_4[16]), .A2(n73), .B1(FIFO_MEM_3[16]), .B2(n72), 
        .Q(n11) );
  NAND2XL U148 ( .A(n12), .B(n11), .Q(Data_out[16]) );
  AOI22X1 U149 ( .A1(FIFO_MEM_2[31]), .A2(n71), .B1(FIFO_MEM_1[31]), .B2(n13), 
        .Q(n15) );
  AOI22X1 U150 ( .A1(FIFO_MEM_4[31]), .A2(n73), .B1(FIFO_MEM_3[31]), .B2(n72), 
        .Q(n14) );
  NAND2XL U151 ( .A(n15), .B(n14), .Q(Data_out[31]) );
  AOI22X1 U152 ( .A1(FIFO_MEM_2[14]), .A2(n71), .B1(FIFO_MEM_1[14]), .B2(n70), 
        .Q(n17) );
  AOI22X1 U153 ( .A1(FIFO_MEM_4[14]), .A2(n73), .B1(FIFO_MEM_3[14]), .B2(n72), 
        .Q(n16) );
  NAND2XL U154 ( .A(n17), .B(n16), .Q(Data_out[14]) );
  AOI22X1 U155 ( .A1(FIFO_MEM_2[15]), .A2(n71), .B1(FIFO_MEM_1[15]), .B2(n70), 
        .Q(n19) );
  AOI22X1 U156 ( .A1(FIFO_MEM_4[15]), .A2(n73), .B1(FIFO_MEM_3[15]), .B2(n72), 
        .Q(n18) );
  NAND2XL U157 ( .A(n19), .B(n18), .Q(Data_out[15]) );
  AOI22X1 U158 ( .A1(FIFO_MEM_2[13]), .A2(n71), .B1(FIFO_MEM_1[13]), .B2(n70), 
        .Q(n21) );
  AOI22X1 U159 ( .A1(FIFO_MEM_4[13]), .A2(n73), .B1(FIFO_MEM_3[13]), .B2(n72), 
        .Q(n20) );
  NAND2XL U160 ( .A(n21), .B(n20), .Q(Data_out[13]) );
  AOI22X1 U161 ( .A1(FIFO_MEM_2[0]), .A2(n71), .B1(FIFO_MEM_1[0]), .B2(n70), 
        .Q(n23) );
  AOI22X1 U162 ( .A1(FIFO_MEM_4[0]), .A2(n73), .B1(FIFO_MEM_3[0]), .B2(n72), 
        .Q(n22) );
  NAND2XL U163 ( .A(n23), .B(n22), .Q(Data_out[0]) );
  AOI22X1 U164 ( .A1(FIFO_MEM_2[10]), .A2(n71), .B1(FIFO_MEM_1[10]), .B2(n70), 
        .Q(n25) );
  AOI22X1 U165 ( .A1(FIFO_MEM_4[10]), .A2(n73), .B1(FIFO_MEM_3[10]), .B2(n72), 
        .Q(n24) );
  NAND2XL U166 ( .A(n25), .B(n24), .Q(Data_out[10]) );
  AOI22X1 U167 ( .A1(FIFO_MEM_2[22]), .A2(n71), .B1(FIFO_MEM_1[22]), .B2(n70), 
        .Q(n27) );
  AOI22X1 U168 ( .A1(FIFO_MEM_4[22]), .A2(n73), .B1(FIFO_MEM_3[22]), .B2(n72), 
        .Q(n26) );
  NAND2XL U169 ( .A(n27), .B(n26), .Q(Data_out[22]) );
  AOI22X1 U170 ( .A1(FIFO_MEM_2[28]), .A2(n71), .B1(FIFO_MEM_1[28]), .B2(n70), 
        .Q(n29) );
  AOI22X1 U171 ( .A1(FIFO_MEM_4[28]), .A2(n73), .B1(FIFO_MEM_3[28]), .B2(n72), 
        .Q(n28) );
  NAND2XL U172 ( .A(n29), .B(n28), .Q(Data_out[28]) );
  AOI22X1 U173 ( .A1(FIFO_MEM_2[17]), .A2(n71), .B1(FIFO_MEM_1[17]), .B2(n70), 
        .Q(n31) );
  AOI22X1 U174 ( .A1(FIFO_MEM_4[17]), .A2(n73), .B1(FIFO_MEM_3[17]), .B2(n72), 
        .Q(n30) );
  NAND2XL U175 ( .A(n31), .B(n30), .Q(Data_out[17]) );
  AOI22X1 U176 ( .A1(FIFO_MEM_2[18]), .A2(n71), .B1(FIFO_MEM_1[18]), .B2(n70), 
        .Q(n33) );
  AOI22X1 U177 ( .A1(FIFO_MEM_4[18]), .A2(n73), .B1(FIFO_MEM_3[18]), .B2(n72), 
        .Q(n32) );
  NAND2XL U178 ( .A(n33), .B(n32), .Q(Data_out[18]) );
  AOI22X1 U179 ( .A1(FIFO_MEM_2[19]), .A2(n71), .B1(FIFO_MEM_1[19]), .B2(n70), 
        .Q(n35) );
  AOI22X1 U180 ( .A1(FIFO_MEM_4[19]), .A2(n73), .B1(FIFO_MEM_3[19]), .B2(n72), 
        .Q(n34) );
  NAND2XL U181 ( .A(n35), .B(n34), .Q(Data_out[19]) );
  AOI22X1 U182 ( .A1(FIFO_MEM_2[20]), .A2(n71), .B1(FIFO_MEM_1[20]), .B2(n70), 
        .Q(n37) );
  AOI22X1 U183 ( .A1(FIFO_MEM_4[20]), .A2(n73), .B1(FIFO_MEM_3[20]), .B2(n72), 
        .Q(n36) );
  NAND2XL U184 ( .A(n37), .B(n36), .Q(Data_out[20]) );
  AOI22X1 U185 ( .A1(FIFO_MEM_2[21]), .A2(n71), .B1(FIFO_MEM_1[21]), .B2(n70), 
        .Q(n39) );
  AOI22X1 U186 ( .A1(FIFO_MEM_4[21]), .A2(n73), .B1(FIFO_MEM_3[21]), .B2(n72), 
        .Q(n38) );
  NAND2XL U187 ( .A(n39), .B(n38), .Q(Data_out[21]) );
  AOI22X1 U188 ( .A1(FIFO_MEM_2[12]), .A2(n71), .B1(FIFO_MEM_1[12]), .B2(n70), 
        .Q(n41) );
  AOI22X1 U189 ( .A1(FIFO_MEM_4[12]), .A2(n73), .B1(FIFO_MEM_3[12]), .B2(n72), 
        .Q(n40) );
  NAND2XL U190 ( .A(n41), .B(n40), .Q(Data_out[12]) );
  AOI22X1 U191 ( .A1(FIFO_MEM_2[27]), .A2(n71), .B1(FIFO_MEM_1[27]), .B2(n70), 
        .Q(n43) );
  AOI22X1 U192 ( .A1(FIFO_MEM_4[27]), .A2(n73), .B1(FIFO_MEM_3[27]), .B2(n72), 
        .Q(n42) );
  NAND2XL U193 ( .A(n43), .B(n42), .Q(Data_out[27]) );
  AOI22X1 U194 ( .A1(FIFO_MEM_2[11]), .A2(n71), .B1(FIFO_MEM_1[11]), .B2(n70), 
        .Q(n45) );
  AOI22X1 U195 ( .A1(FIFO_MEM_4[11]), .A2(n73), .B1(FIFO_MEM_3[11]), .B2(n72), 
        .Q(n44) );
  NAND2XL U196 ( .A(n45), .B(n44), .Q(Data_out[11]) );
  AOI22X1 U197 ( .A1(FIFO_MEM_2[24]), .A2(n71), .B1(FIFO_MEM_1[24]), .B2(n70), 
        .Q(n47) );
  AOI22X1 U198 ( .A1(FIFO_MEM_4[24]), .A2(n73), .B1(FIFO_MEM_3[24]), .B2(n72), 
        .Q(n46) );
  NAND2XL U199 ( .A(n47), .B(n46), .Q(Data_out[24]) );
  AOI22X1 U200 ( .A1(FIFO_MEM_2[26]), .A2(n71), .B1(FIFO_MEM_1[26]), .B2(n70), 
        .Q(n49) );
  AOI22X1 U201 ( .A1(FIFO_MEM_4[26]), .A2(n73), .B1(FIFO_MEM_3[26]), .B2(n72), 
        .Q(n48) );
  NAND2XL U202 ( .A(n49), .B(n48), .Q(Data_out[26]) );
  AOI22X1 U203 ( .A1(FIFO_MEM_2[23]), .A2(n71), .B1(FIFO_MEM_1[23]), .B2(n70), 
        .Q(n51) );
  AOI22X1 U204 ( .A1(FIFO_MEM_4[23]), .A2(n73), .B1(FIFO_MEM_3[23]), .B2(n72), 
        .Q(n50) );
  NAND2XL U205 ( .A(n51), .B(n50), .Q(Data_out[23]) );
  AOI22X1 U206 ( .A1(FIFO_MEM_2[25]), .A2(n71), .B1(FIFO_MEM_1[25]), .B2(n70), 
        .Q(n53) );
  AOI22X1 U207 ( .A1(FIFO_MEM_4[25]), .A2(n73), .B1(FIFO_MEM_3[25]), .B2(n72), 
        .Q(n52) );
  NAND2XL U208 ( .A(n53), .B(n52), .Q(Data_out[25]) );
  INVXL U209 ( .A(read_en), .Q(n93) );
  AOI22X1 U210 ( .A1(read_en), .A2(n103), .B1(n100), .B2(n93), .Q(
        read_pointer_in[1]) );
  AOI22X1 U211 ( .A1(FIFO_MEM_2[3]), .A2(n71), .B1(FIFO_MEM_1[3]), .B2(n70), 
        .Q(n55) );
  AOI22X1 U212 ( .A1(FIFO_MEM_4[3]), .A2(n73), .B1(FIFO_MEM_3[3]), .B2(n72), 
        .Q(n54) );
  NAND2XL U213 ( .A(n55), .B(n54), .Q(Data_out[3]) );
  AOI22X1 U214 ( .A1(FIFO_MEM_2[1]), .A2(n71), .B1(FIFO_MEM_1[1]), .B2(n70), 
        .Q(n57) );
  AOI22X1 U215 ( .A1(FIFO_MEM_4[1]), .A2(n73), .B1(FIFO_MEM_3[1]), .B2(n72), 
        .Q(n56) );
  NAND2XL U216 ( .A(n57), .B(n56), .Q(Data_out[1]) );
  AOI22X1 U217 ( .A1(FIFO_MEM_2[2]), .A2(n71), .B1(FIFO_MEM_1[2]), .B2(n70), 
        .Q(n59) );
  AOI22X1 U218 ( .A1(FIFO_MEM_4[2]), .A2(n73), .B1(FIFO_MEM_3[2]), .B2(n72), 
        .Q(n58) );
  NAND2XL U219 ( .A(n59), .B(n58), .Q(Data_out[2]) );
  AOI22X1 U220 ( .A1(FIFO_MEM_2[4]), .A2(n71), .B1(FIFO_MEM_1[4]), .B2(n70), 
        .Q(n61) );
  AOI22X1 U221 ( .A1(FIFO_MEM_4[4]), .A2(n73), .B1(FIFO_MEM_3[4]), .B2(n72), 
        .Q(n60) );
  NAND2XL U222 ( .A(n61), .B(n60), .Q(Data_out[4]) );
  AOI22X1 U223 ( .A1(FIFO_MEM_2[5]), .A2(n71), .B1(FIFO_MEM_1[5]), .B2(n70), 
        .Q(n63) );
  AOI22X1 U224 ( .A1(FIFO_MEM_4[5]), .A2(n73), .B1(FIFO_MEM_3[5]), .B2(n72), 
        .Q(n62) );
  NAND2XL U225 ( .A(n63), .B(n62), .Q(Data_out[5]) );
  AOI22X1 U226 ( .A1(FIFO_MEM_2[6]), .A2(n71), .B1(FIFO_MEM_1[6]), .B2(n70), 
        .Q(n65) );
  AOI22X1 U227 ( .A1(FIFO_MEM_4[6]), .A2(n73), .B1(FIFO_MEM_3[6]), .B2(n72), 
        .Q(n64) );
  NAND2XL U228 ( .A(n65), .B(n64), .Q(Data_out[6]) );
  AOI22X1 U229 ( .A1(FIFO_MEM_2[7]), .A2(n71), .B1(FIFO_MEM_1[7]), .B2(n70), 
        .Q(n67) );
  AOI22X1 U230 ( .A1(FIFO_MEM_4[7]), .A2(n73), .B1(FIFO_MEM_3[7]), .B2(n72), 
        .Q(n66) );
  NAND2XL U231 ( .A(n67), .B(n66), .Q(Data_out[7]) );
  AOI22X1 U232 ( .A1(FIFO_MEM_2[8]), .A2(n71), .B1(FIFO_MEM_1[8]), .B2(n70), 
        .Q(n69) );
  AOI22X1 U233 ( .A1(FIFO_MEM_4[8]), .A2(n73), .B1(FIFO_MEM_3[8]), .B2(n72), 
        .Q(n68) );
  NAND2XL U234 ( .A(n69), .B(n68), .Q(Data_out[8]) );
  AOI22X1 U235 ( .A1(FIFO_MEM_2[9]), .A2(n71), .B1(FIFO_MEM_1[9]), .B2(n70), 
        .Q(n75) );
  AOI22X1 U236 ( .A1(FIFO_MEM_4[9]), .A2(n73), .B1(FIFO_MEM_3[9]), .B2(n72), 
        .Q(n74) );
  NAND2XL U237 ( .A(n75), .B(n74), .Q(Data_out[9]) );
  AOI22X1 U238 ( .A1(n102), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .Q(n76) );
  OAI221X1 U239 ( .A1(n102), .A2(read_pointer[1]), .B1(n96), .B2(
        read_pointer[0]), .C1(n76), .Q(n77) );
  AO21X1 U240 ( .A1(write_pointer[1]), .A2(n94), .B1(n83), .Q(
        write_pointer_in[1]) );
  NOR2XL U241 ( .A(write_pointer[2]), .B(write_pointer[1]), .Q(n84) );
  NAND3X1 U242 ( .A(write_pointer[3]), .B(n84), .C(n102), .Q(n80) );
  AO22X2 U243 ( .A1(n85), .A2(RX[24]), .B1(n1), .B2(FIFO_MEM_1[24]), .Q(n116)
         );
  AO22X2 U244 ( .A1(n85), .A2(RX[23]), .B1(n1), .B2(FIFO_MEM_1[23]), .Q(n117)
         );
  AO22X2 U245 ( .A1(n85), .A2(RX[22]), .B1(n1), .B2(FIFO_MEM_1[22]), .Q(n118)
         );
  AO22X2 U246 ( .A1(n85), .A2(RX[21]), .B1(n1), .B2(FIFO_MEM_1[21]), .Q(n119)
         );
  AO22X2 U247 ( .A1(n85), .A2(RX[20]), .B1(n1), .B2(FIFO_MEM_1[20]), .Q(n120)
         );
  AO22X2 U248 ( .A1(n85), .A2(RX[19]), .B1(n1), .B2(FIFO_MEM_1[19]), .Q(n121)
         );
  AO22X2 U249 ( .A1(n85), .A2(RX[18]), .B1(n1), .B2(FIFO_MEM_1[18]), .Q(n122)
         );
  AO22X2 U250 ( .A1(n85), .A2(RX[28]), .B1(n1), .B2(FIFO_MEM_1[28]), .Q(n112)
         );
  AO22X2 U251 ( .A1(n85), .A2(RX[27]), .B1(n1), .B2(FIFO_MEM_1[27]), .Q(n113)
         );
  AO22X2 U252 ( .A1(n85), .A2(RX[26]), .B1(n1), .B2(FIFO_MEM_1[26]), .Q(n114)
         );
  AO22X2 U253 ( .A1(n85), .A2(RX[25]), .B1(n1), .B2(FIFO_MEM_1[25]), .Q(n115)
         );
  AO22X2 U254 ( .A1(n85), .A2(RX[17]), .B1(n1), .B2(FIFO_MEM_1[17]), .Q(n123)
         );
  AO22X2 U255 ( .A1(n85), .A2(RX[29]), .B1(n1), .B2(FIFO_MEM_1[29]), .Q(n111)
         );
  AO22X2 U256 ( .A1(n85), .A2(RX[16]), .B1(n1), .B2(FIFO_MEM_1[16]), .Q(n124)
         );
  AO22X2 U257 ( .A1(n85), .A2(RX[15]), .B1(n1), .B2(FIFO_MEM_1[15]), .Q(n125)
         );
  NOR2XL U258 ( .A(write_pointer[3]), .B(write_pointer[0]), .Q(n87) );
  NAND3X1 U259 ( .A(n101), .B(write_pointer[1]), .C(n87), .Q(n86) );
  NAND3X1 U260 ( .A(write_pointer[2]), .B(n87), .C(n99), .Q(n88) );
  AOI22X1 U261 ( .A1(read_en), .A2(n98), .B1(n103), .B2(n93), .Q(
        read_pointer_in[0]) );
  AOI22X1 U262 ( .A1(read_en), .A2(n100), .B1(n97), .B2(n93), .Q(
        read_pointer_in[2]) );
  AOI22X1 U263 ( .A1(read_en), .A2(n97), .B1(n98), .B2(n93), .Q(
        read_pointer_in[3]) );
  INVXL U264 ( .A(n94), .Q(n95) );
  AOI22X1 U265 ( .A1(n95), .A2(n96), .B1(n102), .B2(n94), .Q(
        write_pointer_in[0]) );
  AOI22X1 U266 ( .A1(n95), .A2(n99), .B1(n101), .B2(n94), .Q(
        write_pointer_in[2]) );
  AOI22X1 U267 ( .A1(n95), .A2(n101), .B1(n96), .B2(n94), .Q(
        write_pointer_in[3]) );
endmodule


module FIFO_credit_based_DATA_WIDTH32_0 ( reset, clk, RX, valid_in, read_en_N, 
        read_en_E, read_en_W, read_en_S, read_en_L, credit_out, empty_out, 
        Data_out );
  input [31:0] RX;
  output [31:0] Data_out;
  input reset, clk, valid_in, read_en_N, read_en_E, read_en_W, read_en_S,
         read_en_L;
  output credit_out, empty_out;
  wire   read_en, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103;
  wire   [3:0] read_pointer;
  wire   [3:0] write_pointer;
  wire   [31:0] FIFO_MEM_1;
  wire   [31:0] FIFO_MEM_2;
  wire   [31:0] FIFO_MEM_3;
  wire   [31:0] FIFO_MEM_4;
  wire   [3:0] write_pointer_in;
  wire   [3:0] read_pointer_in;

  DFPX1 \write_pointer_reg[0]  ( .D(write_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(write_pointer[0]), .QN(n103) );
  DFCX1 \write_pointer_reg[1]  ( .D(write_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(write_pointer[1]), .QN(n97) );
  DFCX1 \write_pointer_reg[2]  ( .D(write_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(write_pointer[2]), .QN(n101) );
  DFCX1 \write_pointer_reg[3]  ( .D(write_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(write_pointer[3]), .QN(n98) );
  DFCX1 \read_pointer_reg[3]  ( .D(read_pointer_in[3]), .CP(clk), .RN(reset), 
        .Q(read_pointer[3]), .QN(n96) );
  DFCX1 \read_pointer_reg[1]  ( .D(read_pointer_in[1]), .CP(clk), .RN(reset), 
        .Q(read_pointer[1]), .QN(n102) );
  DFCX1 \read_pointer_reg[2]  ( .D(read_pointer_in[2]), .CP(clk), .RN(reset), 
        .Q(read_pointer[2]), .QN(n99) );
  DFCX1 \FIFO_MEM_1_reg[31]  ( .D(n109), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[31]) );
  DFCX1 \FIFO_MEM_1_reg[30]  ( .D(n110), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[30]) );
  DFCX1 \FIFO_MEM_1_reg[29]  ( .D(n111), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[29]) );
  DFCX1 \FIFO_MEM_1_reg[28]  ( .D(n112), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[28]) );
  DFCX1 \FIFO_MEM_1_reg[27]  ( .D(n113), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[27]) );
  DFCX1 \FIFO_MEM_1_reg[26]  ( .D(n114), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[26]) );
  DFCX1 \FIFO_MEM_1_reg[25]  ( .D(n115), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[25]) );
  DFCX1 \FIFO_MEM_1_reg[24]  ( .D(n116), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[24]) );
  DFCX1 \FIFO_MEM_1_reg[23]  ( .D(n117), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[23]) );
  DFCX1 \FIFO_MEM_1_reg[22]  ( .D(n118), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[22]) );
  DFCX1 \FIFO_MEM_1_reg[21]  ( .D(n119), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[21]) );
  DFCX1 \FIFO_MEM_1_reg[20]  ( .D(n120), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[20]) );
  DFCX1 \FIFO_MEM_1_reg[19]  ( .D(n121), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[19]) );
  DFCX1 \FIFO_MEM_1_reg[18]  ( .D(n122), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[18]) );
  DFCX1 \FIFO_MEM_1_reg[17]  ( .D(n123), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[17]) );
  DFCX1 \FIFO_MEM_1_reg[16]  ( .D(n124), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[16]) );
  DFCX1 \FIFO_MEM_1_reg[15]  ( .D(n125), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[15]) );
  DFCX1 \FIFO_MEM_1_reg[14]  ( .D(n126), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[14]) );
  DFCX1 \FIFO_MEM_1_reg[13]  ( .D(n127), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[13]) );
  DFCX1 \FIFO_MEM_1_reg[12]  ( .D(n128), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[12]) );
  DFCX1 \FIFO_MEM_1_reg[11]  ( .D(n129), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[11]) );
  DFCX1 \FIFO_MEM_1_reg[10]  ( .D(n130), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_1[10]) );
  DFCX1 \FIFO_MEM_1_reg[9]  ( .D(n131), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[9]) );
  DFCX1 \FIFO_MEM_1_reg[8]  ( .D(n132), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[8]) );
  DFCX1 \FIFO_MEM_1_reg[7]  ( .D(n133), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[7]) );
  DFCX1 \FIFO_MEM_1_reg[6]  ( .D(n134), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[6]) );
  DFCX1 \FIFO_MEM_1_reg[5]  ( .D(n135), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[5]) );
  DFCX1 \FIFO_MEM_1_reg[4]  ( .D(n136), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[4]) );
  DFCX1 \FIFO_MEM_1_reg[3]  ( .D(n137), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[3]) );
  DFCX1 \FIFO_MEM_1_reg[2]  ( .D(n138), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[2]) );
  DFCX1 \FIFO_MEM_1_reg[1]  ( .D(n139), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[1]) );
  DFCX1 \FIFO_MEM_1_reg[0]  ( .D(n140), .CP(clk), .RN(reset), .Q(FIFO_MEM_1[0]) );
  DFCX1 \FIFO_MEM_2_reg[31]  ( .D(n141), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[31]) );
  DFCX1 \FIFO_MEM_2_reg[30]  ( .D(n142), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[30]) );
  DFCX1 \FIFO_MEM_2_reg[29]  ( .D(n143), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[29]) );
  DFCX1 \FIFO_MEM_2_reg[28]  ( .D(n144), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[28]) );
  DFCX1 \FIFO_MEM_2_reg[27]  ( .D(n145), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[27]) );
  DFCX1 \FIFO_MEM_2_reg[26]  ( .D(n146), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[26]) );
  DFCX1 \FIFO_MEM_2_reg[25]  ( .D(n147), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[25]) );
  DFCX1 \FIFO_MEM_2_reg[24]  ( .D(n148), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[24]) );
  DFCX1 \FIFO_MEM_2_reg[23]  ( .D(n149), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[23]) );
  DFCX1 \FIFO_MEM_2_reg[22]  ( .D(n150), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[22]) );
  DFCX1 \FIFO_MEM_2_reg[21]  ( .D(n151), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[21]) );
  DFCX1 \FIFO_MEM_2_reg[20]  ( .D(n152), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[20]) );
  DFCX1 \FIFO_MEM_2_reg[19]  ( .D(n153), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[19]) );
  DFCX1 \FIFO_MEM_2_reg[18]  ( .D(n154), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[18]) );
  DFCX1 \FIFO_MEM_2_reg[17]  ( .D(n155), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[17]) );
  DFCX1 \FIFO_MEM_2_reg[16]  ( .D(n156), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[16]) );
  DFCX1 \FIFO_MEM_2_reg[15]  ( .D(n157), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[15]) );
  DFCX1 \FIFO_MEM_2_reg[14]  ( .D(n158), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[14]) );
  DFCX1 \FIFO_MEM_2_reg[13]  ( .D(n159), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[13]) );
  DFCX1 \FIFO_MEM_2_reg[12]  ( .D(n160), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[12]) );
  DFCX1 \FIFO_MEM_2_reg[11]  ( .D(n161), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[11]) );
  DFCX1 \FIFO_MEM_2_reg[10]  ( .D(n162), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_2[10]) );
  DFCX1 \FIFO_MEM_2_reg[9]  ( .D(n163), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[9]) );
  DFCX1 \FIFO_MEM_2_reg[8]  ( .D(n164), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[8]) );
  DFCX1 \FIFO_MEM_2_reg[7]  ( .D(n165), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[7]) );
  DFCX1 \FIFO_MEM_2_reg[6]  ( .D(n166), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[6]) );
  DFCX1 \FIFO_MEM_2_reg[5]  ( .D(n167), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[5]) );
  DFCX1 \FIFO_MEM_2_reg[4]  ( .D(n168), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[4]) );
  DFCX1 \FIFO_MEM_2_reg[3]  ( .D(n169), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[3]) );
  DFCX1 \FIFO_MEM_2_reg[2]  ( .D(n170), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[2]) );
  DFCX1 \FIFO_MEM_2_reg[1]  ( .D(n171), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[1]) );
  DFCX1 \FIFO_MEM_2_reg[0]  ( .D(n172), .CP(clk), .RN(reset), .Q(FIFO_MEM_2[0]) );
  DFCX1 \FIFO_MEM_3_reg[31]  ( .D(n173), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[31]) );
  DFCX1 \FIFO_MEM_3_reg[30]  ( .D(n174), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[30]) );
  DFCX1 \FIFO_MEM_3_reg[29]  ( .D(n175), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[29]) );
  DFCX1 \FIFO_MEM_3_reg[28]  ( .D(n176), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[28]) );
  DFCX1 \FIFO_MEM_3_reg[27]  ( .D(n177), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[27]) );
  DFCX1 \FIFO_MEM_3_reg[26]  ( .D(n178), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[26]) );
  DFCX1 \FIFO_MEM_3_reg[25]  ( .D(n179), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[25]) );
  DFCX1 \FIFO_MEM_3_reg[24]  ( .D(n180), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[24]) );
  DFCX1 \FIFO_MEM_3_reg[23]  ( .D(n181), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[23]) );
  DFCX1 \FIFO_MEM_3_reg[22]  ( .D(n182), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[22]) );
  DFCX1 \FIFO_MEM_3_reg[21]  ( .D(n183), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[21]) );
  DFCX1 \FIFO_MEM_3_reg[20]  ( .D(n184), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[20]) );
  DFCX1 \FIFO_MEM_3_reg[19]  ( .D(n185), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[19]) );
  DFCX1 \FIFO_MEM_3_reg[18]  ( .D(n186), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[18]) );
  DFCX1 \FIFO_MEM_3_reg[17]  ( .D(n187), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[17]) );
  DFCX1 \FIFO_MEM_3_reg[16]  ( .D(n188), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[16]) );
  DFCX1 \FIFO_MEM_3_reg[15]  ( .D(n189), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[15]) );
  DFCX1 \FIFO_MEM_3_reg[14]  ( .D(n190), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[14]) );
  DFCX1 \FIFO_MEM_3_reg[13]  ( .D(n191), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[13]) );
  DFCX1 \FIFO_MEM_3_reg[12]  ( .D(n192), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[12]) );
  DFCX1 \FIFO_MEM_3_reg[11]  ( .D(n193), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[11]) );
  DFCX1 \FIFO_MEM_3_reg[10]  ( .D(n194), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_3[10]) );
  DFCX1 \FIFO_MEM_3_reg[9]  ( .D(n195), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[9]) );
  DFCX1 \FIFO_MEM_3_reg[8]  ( .D(n196), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[8]) );
  DFCX1 \FIFO_MEM_3_reg[7]  ( .D(n197), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[7]) );
  DFCX1 \FIFO_MEM_3_reg[6]  ( .D(n198), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[6]) );
  DFCX1 \FIFO_MEM_3_reg[5]  ( .D(n199), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[5]) );
  DFCX1 \FIFO_MEM_3_reg[4]  ( .D(n200), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[4]) );
  DFCX1 \FIFO_MEM_3_reg[3]  ( .D(n201), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[3]) );
  DFCX1 \FIFO_MEM_3_reg[2]  ( .D(n202), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[2]) );
  DFCX1 \FIFO_MEM_3_reg[1]  ( .D(n203), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[1]) );
  DFCX1 \FIFO_MEM_3_reg[0]  ( .D(n204), .CP(clk), .RN(reset), .Q(FIFO_MEM_3[0]) );
  DFCX1 \FIFO_MEM_4_reg[31]  ( .D(n205), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[31]) );
  DFCX1 \FIFO_MEM_4_reg[30]  ( .D(n206), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[30]) );
  DFCX1 \FIFO_MEM_4_reg[29]  ( .D(n207), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[29]) );
  DFCX1 \FIFO_MEM_4_reg[28]  ( .D(n208), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[28]) );
  DFCX1 \FIFO_MEM_4_reg[27]  ( .D(n209), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[27]) );
  DFCX1 \FIFO_MEM_4_reg[26]  ( .D(n210), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[26]) );
  DFCX1 \FIFO_MEM_4_reg[25]  ( .D(n211), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[25]) );
  DFCX1 \FIFO_MEM_4_reg[24]  ( .D(n212), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[24]) );
  DFCX1 \FIFO_MEM_4_reg[23]  ( .D(n213), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[23]) );
  DFCX1 \FIFO_MEM_4_reg[22]  ( .D(n214), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[22]) );
  DFCX1 \FIFO_MEM_4_reg[21]  ( .D(n215), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[21]) );
  DFCX1 \FIFO_MEM_4_reg[20]  ( .D(n216), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[20]) );
  DFCX1 \FIFO_MEM_4_reg[19]  ( .D(n217), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[19]) );
  DFCX1 \FIFO_MEM_4_reg[18]  ( .D(n218), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[18]) );
  DFCX1 \FIFO_MEM_4_reg[17]  ( .D(n219), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[17]) );
  DFCX1 \FIFO_MEM_4_reg[16]  ( .D(n220), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[16]) );
  DFCX1 \FIFO_MEM_4_reg[15]  ( .D(n221), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[15]) );
  DFCX1 \FIFO_MEM_4_reg[14]  ( .D(n222), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[14]) );
  DFCX1 \FIFO_MEM_4_reg[13]  ( .D(n223), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[13]) );
  DFCX1 \FIFO_MEM_4_reg[12]  ( .D(n224), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[12]) );
  DFCX1 \FIFO_MEM_4_reg[11]  ( .D(n225), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[11]) );
  DFCX1 \FIFO_MEM_4_reg[10]  ( .D(n226), .CP(clk), .RN(reset), .Q(
        FIFO_MEM_4[10]) );
  DFCX1 \FIFO_MEM_4_reg[9]  ( .D(n227), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[9]) );
  DFCX1 \FIFO_MEM_4_reg[8]  ( .D(n228), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[8]) );
  DFCX1 \FIFO_MEM_4_reg[7]  ( .D(n229), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[7]) );
  DFCX1 \FIFO_MEM_4_reg[6]  ( .D(n230), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[6]) );
  DFCX1 \FIFO_MEM_4_reg[5]  ( .D(n231), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[5]) );
  DFCX1 \FIFO_MEM_4_reg[4]  ( .D(n232), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[4]) );
  DFCX1 \FIFO_MEM_4_reg[3]  ( .D(n233), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[3]) );
  DFCX1 \FIFO_MEM_4_reg[2]  ( .D(n234), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[2]) );
  DFCX1 \FIFO_MEM_4_reg[1]  ( .D(n235), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[1]) );
  DFCX1 \FIFO_MEM_4_reg[0]  ( .D(n236), .CP(clk), .RN(reset), .Q(FIFO_MEM_4[0]) );
  DFCX1 credit_out_reg ( .D(read_en), .CP(clk), .RN(reset), .Q(credit_out) );
  DFPX3 \read_pointer_reg[0]  ( .D(read_pointer_in[0]), .CP(clk), .SN(reset), 
        .Q(read_pointer[0]), .QN(n100) );
  AND3X2 U3 ( .A(n84), .B(n83), .C(n98), .Q(n85) );
  NOR3X3 U4 ( .A(n72), .B(n73), .C(n71), .Q(n11) );
  NAND2XL U5 ( .A(n100), .B(n102), .Q(n6) );
  AOI221X1 U6 ( .A1(write_pointer[1]), .A2(n99), .B1(n97), .B2(read_pointer[2]), .C1(n77), .Q(n78) );
  CLKINVX2 U7 ( .A(n85), .Q(n1) );
  NAND2X3 U8 ( .A(valid_in), .B(n79), .Q(n94) );
  OAI221X2 U9 ( .A1(write_pointer[2]), .A2(n96), .B1(n101), .B2(
        read_pointer[3]), .C1(n78), .Q(n79) );
  AO22X2 U10 ( .A1(n85), .A2(RX[5]), .B1(n1), .B2(FIFO_MEM_1[5]), .Q(n135) );
  AO22X2 U11 ( .A1(n85), .A2(RX[3]), .B1(n1), .B2(FIFO_MEM_1[3]), .Q(n137) );
  AO22X2 U12 ( .A1(n85), .A2(RX[4]), .B1(n1), .B2(FIFO_MEM_1[4]), .Q(n136) );
  AO22X2 U13 ( .A1(n85), .A2(RX[2]), .B1(n1), .B2(FIFO_MEM_1[2]), .Q(n138) );
  AO22X2 U14 ( .A1(n85), .A2(RX[1]), .B1(n1), .B2(FIFO_MEM_1[1]), .Q(n139) );
  AO22X2 U15 ( .A1(n85), .A2(RX[0]), .B1(n1), .B2(FIFO_MEM_1[0]), .Q(n140) );
  AO22X2 U16 ( .A1(n85), .A2(RX[13]), .B1(n1), .B2(FIFO_MEM_1[13]), .Q(n127)
         );
  AO22X2 U17 ( .A1(n85), .A2(RX[7]), .B1(n1), .B2(FIFO_MEM_1[7]), .Q(n133) );
  AO22X2 U18 ( .A1(n85), .A2(RX[14]), .B1(n1), .B2(FIFO_MEM_1[14]), .Q(n126)
         );
  AO22X2 U19 ( .A1(n85), .A2(RX[12]), .B1(n1), .B2(FIFO_MEM_1[12]), .Q(n128)
         );
  AO22X2 U20 ( .A1(n85), .A2(RX[11]), .B1(n1), .B2(FIFO_MEM_1[11]), .Q(n129)
         );
  AO22X2 U21 ( .A1(n85), .A2(RX[6]), .B1(n1), .B2(FIFO_MEM_1[6]), .Q(n134) );
  AO22X2 U22 ( .A1(n85), .A2(RX[8]), .B1(n1), .B2(FIFO_MEM_1[8]), .Q(n132) );
  AO22X2 U23 ( .A1(n85), .A2(RX[10]), .B1(n1), .B2(FIFO_MEM_1[10]), .Q(n130)
         );
  AO22X2 U24 ( .A1(n85), .A2(RX[9]), .B1(n1), .B2(FIFO_MEM_1[9]), .Q(n131) );
  NOR4X6 U25 ( .A(read_pointer[0]), .B(read_pointer[3]), .C(read_pointer[2]), 
        .D(n102), .Q(n71) );
  OAI22X1 U26 ( .A1(n97), .A2(read_pointer[1]), .B1(n100), .B2(
        write_pointer[0]), .Q(n2) );
  AOI22X1 U27 ( .A1(FIFO_MEM_2[29]), .A2(n71), .B1(FIFO_MEM_1[29]), .B2(n70), 
        .Q(n8) );
  NOR2X3 U28 ( .A(n94), .B(n80), .Q(n82) );
  NOR2X3 U29 ( .A(n88), .B(n94), .Q(n90) );
  NOR2X3 U30 ( .A(n86), .B(n94), .Q(n92) );
  CLKBUFX2 U31 ( .A(n11), .Q(n70) );
  CLKINVX2 U32 ( .A(n82), .Q(n81) );
  CLKINVX2 U33 ( .A(n90), .Q(n89) );
  CLKINVX2 U34 ( .A(n92), .Q(n91) );
  AO22X1 U35 ( .A1(n82), .A2(RX[0]), .B1(FIFO_MEM_4[0]), .B2(n81), .Q(n236) );
  AO22X1 U36 ( .A1(RX[1]), .A2(n82), .B1(FIFO_MEM_4[1]), .B2(n81), .Q(n235) );
  AO22X1 U37 ( .A1(RX[2]), .A2(n82), .B1(FIFO_MEM_4[2]), .B2(n81), .Q(n234) );
  AO22X1 U38 ( .A1(RX[3]), .A2(n82), .B1(FIFO_MEM_4[3]), .B2(n81), .Q(n233) );
  AO22X1 U39 ( .A1(RX[4]), .A2(n82), .B1(FIFO_MEM_4[4]), .B2(n81), .Q(n232) );
  AO22X1 U40 ( .A1(RX[5]), .A2(n82), .B1(FIFO_MEM_4[5]), .B2(n81), .Q(n231) );
  AO22X1 U41 ( .A1(RX[6]), .A2(n82), .B1(FIFO_MEM_4[6]), .B2(n81), .Q(n230) );
  AO22X1 U42 ( .A1(RX[7]), .A2(n82), .B1(FIFO_MEM_4[7]), .B2(n81), .Q(n229) );
  AO22X1 U43 ( .A1(RX[8]), .A2(n82), .B1(FIFO_MEM_4[8]), .B2(n81), .Q(n228) );
  AO22X1 U44 ( .A1(RX[9]), .A2(n82), .B1(FIFO_MEM_4[9]), .B2(n81), .Q(n227) );
  AO22X1 U45 ( .A1(RX[10]), .A2(n82), .B1(FIFO_MEM_4[10]), .B2(n81), .Q(n226)
         );
  AO22X1 U46 ( .A1(RX[11]), .A2(n82), .B1(FIFO_MEM_4[11]), .B2(n81), .Q(n225)
         );
  AO22X1 U47 ( .A1(RX[12]), .A2(n82), .B1(FIFO_MEM_4[12]), .B2(n81), .Q(n224)
         );
  AO22X1 U48 ( .A1(RX[13]), .A2(n82), .B1(FIFO_MEM_4[13]), .B2(n81), .Q(n223)
         );
  AO22X1 U49 ( .A1(RX[14]), .A2(n82), .B1(FIFO_MEM_4[14]), .B2(n81), .Q(n222)
         );
  AO22X1 U50 ( .A1(RX[15]), .A2(n82), .B1(FIFO_MEM_4[15]), .B2(n81), .Q(n221)
         );
  AO22X1 U51 ( .A1(RX[16]), .A2(n82), .B1(FIFO_MEM_4[16]), .B2(n81), .Q(n220)
         );
  AO22X1 U52 ( .A1(RX[17]), .A2(n82), .B1(FIFO_MEM_4[17]), .B2(n81), .Q(n219)
         );
  AO22X1 U53 ( .A1(RX[18]), .A2(n82), .B1(FIFO_MEM_4[18]), .B2(n81), .Q(n218)
         );
  AO22X1 U54 ( .A1(RX[19]), .A2(n82), .B1(FIFO_MEM_4[19]), .B2(n81), .Q(n217)
         );
  AO22X1 U55 ( .A1(RX[20]), .A2(n82), .B1(FIFO_MEM_4[20]), .B2(n81), .Q(n216)
         );
  AO22X1 U56 ( .A1(RX[21]), .A2(n82), .B1(FIFO_MEM_4[21]), .B2(n81), .Q(n215)
         );
  AO22X1 U57 ( .A1(RX[22]), .A2(n82), .B1(FIFO_MEM_4[22]), .B2(n81), .Q(n214)
         );
  AO22X1 U58 ( .A1(RX[23]), .A2(n82), .B1(FIFO_MEM_4[23]), .B2(n81), .Q(n213)
         );
  AO22X1 U59 ( .A1(RX[24]), .A2(n82), .B1(FIFO_MEM_4[24]), .B2(n81), .Q(n212)
         );
  AO22X1 U60 ( .A1(RX[25]), .A2(n82), .B1(FIFO_MEM_4[25]), .B2(n81), .Q(n211)
         );
  AO22X1 U61 ( .A1(RX[26]), .A2(n82), .B1(FIFO_MEM_4[26]), .B2(n81), .Q(n210)
         );
  AO22X1 U62 ( .A1(RX[27]), .A2(n82), .B1(FIFO_MEM_4[27]), .B2(n81), .Q(n209)
         );
  AO22X1 U63 ( .A1(RX[28]), .A2(n82), .B1(FIFO_MEM_4[28]), .B2(n81), .Q(n208)
         );
  AO22X1 U64 ( .A1(RX[29]), .A2(n82), .B1(FIFO_MEM_4[29]), .B2(n81), .Q(n207)
         );
  AO22X1 U65 ( .A1(RX[30]), .A2(n82), .B1(FIFO_MEM_4[30]), .B2(n81), .Q(n206)
         );
  AO22X1 U66 ( .A1(RX[31]), .A2(n82), .B1(FIFO_MEM_4[31]), .B2(n81), .Q(n205)
         );
  AO22X1 U67 ( .A1(RX[0]), .A2(n90), .B1(FIFO_MEM_3[0]), .B2(n89), .Q(n204) );
  AO22X1 U68 ( .A1(RX[1]), .A2(n90), .B1(FIFO_MEM_3[1]), .B2(n89), .Q(n203) );
  AO22X1 U69 ( .A1(RX[2]), .A2(n90), .B1(FIFO_MEM_3[2]), .B2(n89), .Q(n202) );
  AO22X1 U70 ( .A1(RX[3]), .A2(n90), .B1(FIFO_MEM_3[3]), .B2(n89), .Q(n201) );
  AO22X1 U71 ( .A1(RX[4]), .A2(n90), .B1(FIFO_MEM_3[4]), .B2(n89), .Q(n200) );
  AO22X1 U72 ( .A1(RX[5]), .A2(n90), .B1(FIFO_MEM_3[5]), .B2(n89), .Q(n199) );
  AO22X1 U73 ( .A1(RX[6]), .A2(n90), .B1(FIFO_MEM_3[6]), .B2(n89), .Q(n198) );
  AO22X1 U74 ( .A1(RX[7]), .A2(n90), .B1(FIFO_MEM_3[7]), .B2(n89), .Q(n197) );
  AO22X1 U75 ( .A1(RX[8]), .A2(n90), .B1(FIFO_MEM_3[8]), .B2(n89), .Q(n196) );
  AO22X1 U76 ( .A1(RX[9]), .A2(n90), .B1(FIFO_MEM_3[9]), .B2(n89), .Q(n195) );
  AO22X1 U77 ( .A1(RX[10]), .A2(n90), .B1(FIFO_MEM_3[10]), .B2(n89), .Q(n194)
         );
  AO22X1 U78 ( .A1(RX[11]), .A2(n90), .B1(FIFO_MEM_3[11]), .B2(n89), .Q(n193)
         );
  AO22X1 U79 ( .A1(RX[12]), .A2(n90), .B1(FIFO_MEM_3[12]), .B2(n89), .Q(n192)
         );
  AO22X1 U80 ( .A1(RX[13]), .A2(n90), .B1(FIFO_MEM_3[13]), .B2(n89), .Q(n191)
         );
  AO22X1 U81 ( .A1(RX[14]), .A2(n90), .B1(FIFO_MEM_3[14]), .B2(n89), .Q(n190)
         );
  AO22X1 U82 ( .A1(RX[15]), .A2(n90), .B1(FIFO_MEM_3[15]), .B2(n89), .Q(n189)
         );
  AO22X1 U83 ( .A1(RX[16]), .A2(n90), .B1(FIFO_MEM_3[16]), .B2(n89), .Q(n188)
         );
  AO22X1 U84 ( .A1(RX[17]), .A2(n90), .B1(FIFO_MEM_3[17]), .B2(n89), .Q(n187)
         );
  AO22X1 U85 ( .A1(RX[18]), .A2(n90), .B1(FIFO_MEM_3[18]), .B2(n89), .Q(n186)
         );
  AO22X1 U86 ( .A1(RX[19]), .A2(n90), .B1(FIFO_MEM_3[19]), .B2(n89), .Q(n185)
         );
  AO22X1 U87 ( .A1(RX[20]), .A2(n90), .B1(FIFO_MEM_3[20]), .B2(n89), .Q(n184)
         );
  AO22X1 U88 ( .A1(RX[21]), .A2(n90), .B1(FIFO_MEM_3[21]), .B2(n89), .Q(n183)
         );
  AO22X1 U89 ( .A1(RX[22]), .A2(n90), .B1(FIFO_MEM_3[22]), .B2(n89), .Q(n182)
         );
  AO22X1 U90 ( .A1(RX[23]), .A2(n90), .B1(FIFO_MEM_3[23]), .B2(n89), .Q(n181)
         );
  AO22X1 U91 ( .A1(RX[24]), .A2(n90), .B1(FIFO_MEM_3[24]), .B2(n89), .Q(n180)
         );
  AO22X1 U92 ( .A1(RX[25]), .A2(n90), .B1(FIFO_MEM_3[25]), .B2(n89), .Q(n179)
         );
  AO22X1 U93 ( .A1(RX[26]), .A2(n90), .B1(FIFO_MEM_3[26]), .B2(n89), .Q(n178)
         );
  AO22X1 U94 ( .A1(RX[27]), .A2(n90), .B1(FIFO_MEM_3[27]), .B2(n89), .Q(n177)
         );
  AO22X1 U95 ( .A1(RX[28]), .A2(n90), .B1(FIFO_MEM_3[28]), .B2(n89), .Q(n176)
         );
  AO22X1 U96 ( .A1(RX[29]), .A2(n90), .B1(FIFO_MEM_3[29]), .B2(n89), .Q(n175)
         );
  AO22X1 U97 ( .A1(RX[30]), .A2(n90), .B1(FIFO_MEM_3[30]), .B2(n89), .Q(n174)
         );
  AO22X1 U98 ( .A1(RX[31]), .A2(n90), .B1(FIFO_MEM_3[31]), .B2(n89), .Q(n173)
         );
  AO22X1 U99 ( .A1(RX[0]), .A2(n92), .B1(FIFO_MEM_2[0]), .B2(n91), .Q(n172) );
  AO22X1 U100 ( .A1(RX[1]), .A2(n92), .B1(FIFO_MEM_2[1]), .B2(n91), .Q(n171)
         );
  AO22X1 U101 ( .A1(RX[2]), .A2(n92), .B1(FIFO_MEM_2[2]), .B2(n91), .Q(n170)
         );
  AO22X1 U102 ( .A1(RX[3]), .A2(n92), .B1(FIFO_MEM_2[3]), .B2(n91), .Q(n169)
         );
  AO22X1 U103 ( .A1(RX[4]), .A2(n92), .B1(FIFO_MEM_2[4]), .B2(n91), .Q(n168)
         );
  AO22X1 U104 ( .A1(RX[5]), .A2(n92), .B1(FIFO_MEM_2[5]), .B2(n91), .Q(n167)
         );
  AO22X1 U105 ( .A1(RX[6]), .A2(n92), .B1(FIFO_MEM_2[6]), .B2(n91), .Q(n166)
         );
  AO22X1 U106 ( .A1(RX[7]), .A2(n92), .B1(FIFO_MEM_2[7]), .B2(n91), .Q(n165)
         );
  AO22X1 U107 ( .A1(RX[8]), .A2(n92), .B1(FIFO_MEM_2[8]), .B2(n91), .Q(n164)
         );
  AO22X1 U108 ( .A1(RX[9]), .A2(n92), .B1(FIFO_MEM_2[9]), .B2(n91), .Q(n163)
         );
  AO22X1 U109 ( .A1(RX[10]), .A2(n92), .B1(FIFO_MEM_2[10]), .B2(n91), .Q(n162)
         );
  AO22X1 U110 ( .A1(RX[11]), .A2(n92), .B1(FIFO_MEM_2[11]), .B2(n91), .Q(n161)
         );
  AO22X1 U111 ( .A1(RX[12]), .A2(n92), .B1(FIFO_MEM_2[12]), .B2(n91), .Q(n160)
         );
  AO22X1 U112 ( .A1(RX[13]), .A2(n92), .B1(FIFO_MEM_2[13]), .B2(n91), .Q(n159)
         );
  AO22X1 U113 ( .A1(RX[14]), .A2(n92), .B1(FIFO_MEM_2[14]), .B2(n91), .Q(n158)
         );
  AO22X1 U114 ( .A1(RX[15]), .A2(n92), .B1(FIFO_MEM_2[15]), .B2(n91), .Q(n157)
         );
  AO22X1 U115 ( .A1(RX[16]), .A2(n92), .B1(FIFO_MEM_2[16]), .B2(n91), .Q(n156)
         );
  AO22X1 U116 ( .A1(RX[17]), .A2(n92), .B1(FIFO_MEM_2[17]), .B2(n91), .Q(n155)
         );
  AO22X1 U117 ( .A1(RX[18]), .A2(n92), .B1(FIFO_MEM_2[18]), .B2(n91), .Q(n154)
         );
  AO22X1 U118 ( .A1(RX[19]), .A2(n92), .B1(FIFO_MEM_2[19]), .B2(n91), .Q(n153)
         );
  AO22X1 U119 ( .A1(RX[20]), .A2(n92), .B1(FIFO_MEM_2[20]), .B2(n91), .Q(n152)
         );
  AO22X1 U120 ( .A1(RX[21]), .A2(n92), .B1(FIFO_MEM_2[21]), .B2(n91), .Q(n151)
         );
  AO22X1 U121 ( .A1(RX[22]), .A2(n92), .B1(FIFO_MEM_2[22]), .B2(n91), .Q(n150)
         );
  AO22X1 U122 ( .A1(RX[23]), .A2(n92), .B1(FIFO_MEM_2[23]), .B2(n91), .Q(n149)
         );
  AO22X1 U123 ( .A1(RX[24]), .A2(n92), .B1(FIFO_MEM_2[24]), .B2(n91), .Q(n148)
         );
  AO22X1 U124 ( .A1(RX[25]), .A2(n92), .B1(FIFO_MEM_2[25]), .B2(n91), .Q(n147)
         );
  AO22X1 U125 ( .A1(RX[26]), .A2(n92), .B1(FIFO_MEM_2[26]), .B2(n91), .Q(n146)
         );
  AO22X1 U126 ( .A1(RX[27]), .A2(n92), .B1(FIFO_MEM_2[27]), .B2(n91), .Q(n145)
         );
  AO22X1 U127 ( .A1(RX[28]), .A2(n92), .B1(FIFO_MEM_2[28]), .B2(n91), .Q(n144)
         );
  AO22X1 U128 ( .A1(RX[29]), .A2(n92), .B1(FIFO_MEM_2[29]), .B2(n91), .Q(n143)
         );
  AO22X1 U129 ( .A1(RX[30]), .A2(n92), .B1(FIFO_MEM_2[30]), .B2(n91), .Q(n142)
         );
  AO22X1 U130 ( .A1(RX[31]), .A2(n92), .B1(FIFO_MEM_2[31]), .B2(n91), .Q(n141)
         );
  AO22X1 U131 ( .A1(n85), .A2(RX[30]), .B1(n1), .B2(FIFO_MEM_1[30]), .Q(n110)
         );
  AO22X1 U132 ( .A1(n85), .A2(RX[31]), .B1(n1), .B2(FIFO_MEM_1[31]), .Q(n109)
         );
  AOI221X1 U133 ( .A1(n97), .A2(read_pointer[1]), .B1(write_pointer[0]), .B2(
        n100), .C1(n2), .Q(n3) );
  NOR4X1 U134 ( .A(read_en_N), .B(read_en_E), .C(read_en_W), .D(read_en_S), 
        .Q(n5) );
  NOR2XL U135 ( .A(n103), .B(n94), .Q(n83) );
  OAI221X1 U136 ( .A1(write_pointer[2]), .A2(n99), .B1(n101), .B2(
        read_pointer[2]), .C1(n3), .Q(n4) );
  AOI221X3 U137 ( .A1(write_pointer[3]), .A2(n96), .B1(n98), .B2(
        read_pointer[3]), .C1(n4), .Q(empty_out) );
  NOR2X3 U138 ( .A(empty_out), .B(n5), .Q(read_en) );
  NOR3X3 U139 ( .A(read_pointer[3]), .B(n99), .C(n6), .Q(n72) );
  NOR3X3 U140 ( .A(read_pointer[2]), .B(n96), .C(n6), .Q(n73) );
  AOI22X1 U141 ( .A1(FIFO_MEM_4[29]), .A2(n73), .B1(FIFO_MEM_3[29]), .B2(n72), 
        .Q(n7) );
  NAND2X3 U142 ( .A(n8), .B(n7), .Q(Data_out[29]) );
  AOI22X1 U143 ( .A1(FIFO_MEM_2[31]), .A2(n71), .B1(FIFO_MEM_1[31]), .B2(n11), 
        .Q(n10) );
  AOI22X1 U144 ( .A1(FIFO_MEM_4[31]), .A2(n73), .B1(FIFO_MEM_3[31]), .B2(n72), 
        .Q(n9) );
  NAND2XL U145 ( .A(n10), .B(n9), .Q(Data_out[31]) );
  AOI22X1 U146 ( .A1(FIFO_MEM_2[30]), .A2(n71), .B1(FIFO_MEM_1[30]), .B2(n11), 
        .Q(n13) );
  AOI22X1 U147 ( .A1(FIFO_MEM_4[30]), .A2(n73), .B1(FIFO_MEM_3[30]), .B2(n72), 
        .Q(n12) );
  NAND2XL U148 ( .A(n13), .B(n12), .Q(Data_out[30]) );
  AOI22X1 U149 ( .A1(FIFO_MEM_2[14]), .A2(n71), .B1(FIFO_MEM_1[14]), .B2(n70), 
        .Q(n15) );
  AOI22X1 U150 ( .A1(FIFO_MEM_4[14]), .A2(n73), .B1(FIFO_MEM_3[14]), .B2(n72), 
        .Q(n14) );
  NAND2XL U151 ( .A(n15), .B(n14), .Q(Data_out[14]) );
  AOI22X1 U152 ( .A1(FIFO_MEM_2[16]), .A2(n71), .B1(FIFO_MEM_1[16]), .B2(n70), 
        .Q(n17) );
  AOI22X1 U153 ( .A1(FIFO_MEM_4[16]), .A2(n73), .B1(FIFO_MEM_3[16]), .B2(n72), 
        .Q(n16) );
  NAND2XL U154 ( .A(n17), .B(n16), .Q(Data_out[16]) );
  AOI22X1 U155 ( .A1(FIFO_MEM_2[13]), .A2(n71), .B1(FIFO_MEM_1[13]), .B2(n70), 
        .Q(n19) );
  AOI22X1 U156 ( .A1(FIFO_MEM_4[13]), .A2(n73), .B1(FIFO_MEM_3[13]), .B2(n72), 
        .Q(n18) );
  NAND2XL U157 ( .A(n19), .B(n18), .Q(Data_out[13]) );
  AOI22X1 U158 ( .A1(FIFO_MEM_2[15]), .A2(n71), .B1(FIFO_MEM_1[15]), .B2(n70), 
        .Q(n21) );
  AOI22X1 U159 ( .A1(FIFO_MEM_4[15]), .A2(n73), .B1(FIFO_MEM_3[15]), .B2(n72), 
        .Q(n20) );
  NAND2XL U160 ( .A(n21), .B(n20), .Q(Data_out[15]) );
  INVXL U161 ( .A(read_en), .Q(n93) );
  AOI22X1 U162 ( .A1(read_en), .A2(n100), .B1(n102), .B2(n93), .Q(
        read_pointer_in[1]) );
  AOI22X1 U163 ( .A1(FIFO_MEM_2[9]), .A2(n71), .B1(FIFO_MEM_1[9]), .B2(n70), 
        .Q(n23) );
  AOI22X1 U164 ( .A1(FIFO_MEM_4[9]), .A2(n73), .B1(FIFO_MEM_3[9]), .B2(n72), 
        .Q(n22) );
  NAND2XL U165 ( .A(n23), .B(n22), .Q(Data_out[9]) );
  AOI22X1 U166 ( .A1(FIFO_MEM_2[6]), .A2(n71), .B1(FIFO_MEM_1[6]), .B2(n70), 
        .Q(n25) );
  AOI22X1 U167 ( .A1(FIFO_MEM_4[6]), .A2(n73), .B1(FIFO_MEM_3[6]), .B2(n72), 
        .Q(n24) );
  NAND2XL U168 ( .A(n25), .B(n24), .Q(Data_out[6]) );
  AOI22X1 U169 ( .A1(FIFO_MEM_2[0]), .A2(n71), .B1(FIFO_MEM_1[0]), .B2(n70), 
        .Q(n27) );
  AOI22X1 U170 ( .A1(FIFO_MEM_4[0]), .A2(n73), .B1(FIFO_MEM_3[0]), .B2(n72), 
        .Q(n26) );
  NAND2XL U171 ( .A(n27), .B(n26), .Q(Data_out[0]) );
  AOI22X1 U172 ( .A1(FIFO_MEM_2[10]), .A2(n71), .B1(FIFO_MEM_1[10]), .B2(n70), 
        .Q(n29) );
  AOI22X1 U173 ( .A1(FIFO_MEM_4[10]), .A2(n73), .B1(FIFO_MEM_3[10]), .B2(n72), 
        .Q(n28) );
  NAND2XL U174 ( .A(n29), .B(n28), .Q(Data_out[10]) );
  AOI22X1 U175 ( .A1(FIFO_MEM_2[2]), .A2(n71), .B1(FIFO_MEM_1[2]), .B2(n70), 
        .Q(n31) );
  AOI22X1 U176 ( .A1(FIFO_MEM_4[2]), .A2(n73), .B1(FIFO_MEM_3[2]), .B2(n72), 
        .Q(n30) );
  NAND2XL U177 ( .A(n31), .B(n30), .Q(Data_out[2]) );
  AOI22X1 U178 ( .A1(FIFO_MEM_2[8]), .A2(n71), .B1(FIFO_MEM_1[8]), .B2(n70), 
        .Q(n33) );
  AOI22X1 U179 ( .A1(FIFO_MEM_4[8]), .A2(n73), .B1(FIFO_MEM_3[8]), .B2(n72), 
        .Q(n32) );
  NAND2XL U180 ( .A(n33), .B(n32), .Q(Data_out[8]) );
  AOI22X1 U181 ( .A1(FIFO_MEM_2[7]), .A2(n71), .B1(FIFO_MEM_1[7]), .B2(n70), 
        .Q(n35) );
  AOI22X1 U182 ( .A1(FIFO_MEM_4[7]), .A2(n73), .B1(FIFO_MEM_3[7]), .B2(n72), 
        .Q(n34) );
  NAND2XL U183 ( .A(n35), .B(n34), .Q(Data_out[7]) );
  AOI22X1 U184 ( .A1(FIFO_MEM_2[3]), .A2(n71), .B1(FIFO_MEM_1[3]), .B2(n70), 
        .Q(n37) );
  AOI22X1 U185 ( .A1(FIFO_MEM_4[3]), .A2(n73), .B1(FIFO_MEM_3[3]), .B2(n72), 
        .Q(n36) );
  NAND2XL U186 ( .A(n37), .B(n36), .Q(Data_out[3]) );
  AOI22X1 U187 ( .A1(FIFO_MEM_2[5]), .A2(n71), .B1(FIFO_MEM_1[5]), .B2(n70), 
        .Q(n39) );
  AOI22X1 U188 ( .A1(FIFO_MEM_4[5]), .A2(n73), .B1(FIFO_MEM_3[5]), .B2(n72), 
        .Q(n38) );
  NAND2XL U189 ( .A(n39), .B(n38), .Q(Data_out[5]) );
  AOI22X1 U190 ( .A1(FIFO_MEM_2[4]), .A2(n71), .B1(FIFO_MEM_1[4]), .B2(n70), 
        .Q(n41) );
  AOI22X1 U191 ( .A1(FIFO_MEM_4[4]), .A2(n73), .B1(FIFO_MEM_3[4]), .B2(n72), 
        .Q(n40) );
  NAND2XL U192 ( .A(n41), .B(n40), .Q(Data_out[4]) );
  AOI22X1 U193 ( .A1(FIFO_MEM_2[12]), .A2(n71), .B1(FIFO_MEM_1[12]), .B2(n70), 
        .Q(n43) );
  AOI22X1 U194 ( .A1(FIFO_MEM_4[12]), .A2(n73), .B1(FIFO_MEM_3[12]), .B2(n72), 
        .Q(n42) );
  NAND2XL U195 ( .A(n43), .B(n42), .Q(Data_out[12]) );
  AOI22X1 U196 ( .A1(FIFO_MEM_2[1]), .A2(n71), .B1(FIFO_MEM_1[1]), .B2(n70), 
        .Q(n45) );
  AOI22X1 U197 ( .A1(FIFO_MEM_4[1]), .A2(n73), .B1(FIFO_MEM_3[1]), .B2(n72), 
        .Q(n44) );
  NAND2XL U198 ( .A(n45), .B(n44), .Q(Data_out[1]) );
  AOI22X1 U199 ( .A1(FIFO_MEM_2[11]), .A2(n71), .B1(FIFO_MEM_1[11]), .B2(n70), 
        .Q(n47) );
  AOI22X1 U200 ( .A1(FIFO_MEM_4[11]), .A2(n73), .B1(FIFO_MEM_3[11]), .B2(n72), 
        .Q(n46) );
  NAND2XL U201 ( .A(n47), .B(n46), .Q(Data_out[11]) );
  AOI22X1 U202 ( .A1(FIFO_MEM_2[24]), .A2(n71), .B1(FIFO_MEM_1[24]), .B2(n70), 
        .Q(n49) );
  AOI22X1 U203 ( .A1(FIFO_MEM_4[24]), .A2(n73), .B1(FIFO_MEM_3[24]), .B2(n72), 
        .Q(n48) );
  NAND2XL U204 ( .A(n49), .B(n48), .Q(Data_out[24]) );
  AOI22X1 U205 ( .A1(FIFO_MEM_2[27]), .A2(n71), .B1(FIFO_MEM_1[27]), .B2(n70), 
        .Q(n51) );
  AOI22X1 U206 ( .A1(FIFO_MEM_4[27]), .A2(n73), .B1(FIFO_MEM_3[27]), .B2(n72), 
        .Q(n50) );
  NAND2XL U207 ( .A(n51), .B(n50), .Q(Data_out[27]) );
  AOI22X1 U208 ( .A1(FIFO_MEM_2[20]), .A2(n71), .B1(FIFO_MEM_1[20]), .B2(n70), 
        .Q(n53) );
  AOI22X1 U209 ( .A1(FIFO_MEM_4[20]), .A2(n73), .B1(FIFO_MEM_3[20]), .B2(n72), 
        .Q(n52) );
  NAND2XL U210 ( .A(n53), .B(n52), .Q(Data_out[20]) );
  AOI22X1 U211 ( .A1(FIFO_MEM_2[18]), .A2(n71), .B1(FIFO_MEM_1[18]), .B2(n70), 
        .Q(n55) );
  AOI22X1 U212 ( .A1(FIFO_MEM_4[18]), .A2(n73), .B1(FIFO_MEM_3[18]), .B2(n72), 
        .Q(n54) );
  NAND2XL U213 ( .A(n55), .B(n54), .Q(Data_out[18]) );
  AOI22X1 U214 ( .A1(FIFO_MEM_2[25]), .A2(n71), .B1(FIFO_MEM_1[25]), .B2(n70), 
        .Q(n57) );
  AOI22X1 U215 ( .A1(FIFO_MEM_4[25]), .A2(n73), .B1(FIFO_MEM_3[25]), .B2(n72), 
        .Q(n56) );
  NAND2XL U216 ( .A(n57), .B(n56), .Q(Data_out[25]) );
  AOI22X1 U217 ( .A1(FIFO_MEM_2[17]), .A2(n71), .B1(FIFO_MEM_1[17]), .B2(n70), 
        .Q(n59) );
  AOI22X1 U218 ( .A1(FIFO_MEM_4[17]), .A2(n73), .B1(FIFO_MEM_3[17]), .B2(n72), 
        .Q(n58) );
  NAND2XL U219 ( .A(n59), .B(n58), .Q(Data_out[17]) );
  AOI22X1 U220 ( .A1(FIFO_MEM_2[19]), .A2(n71), .B1(FIFO_MEM_1[19]), .B2(n70), 
        .Q(n61) );
  AOI22X1 U221 ( .A1(FIFO_MEM_4[19]), .A2(n73), .B1(FIFO_MEM_3[19]), .B2(n72), 
        .Q(n60) );
  NAND2XL U222 ( .A(n61), .B(n60), .Q(Data_out[19]) );
  AOI22X1 U223 ( .A1(FIFO_MEM_2[22]), .A2(n71), .B1(FIFO_MEM_1[22]), .B2(n70), 
        .Q(n63) );
  AOI22X1 U224 ( .A1(FIFO_MEM_4[22]), .A2(n73), .B1(FIFO_MEM_3[22]), .B2(n72), 
        .Q(n62) );
  NAND2XL U225 ( .A(n63), .B(n62), .Q(Data_out[22]) );
  AOI22X1 U226 ( .A1(FIFO_MEM_2[21]), .A2(n71), .B1(FIFO_MEM_1[21]), .B2(n70), 
        .Q(n65) );
  AOI22X1 U227 ( .A1(FIFO_MEM_4[21]), .A2(n73), .B1(FIFO_MEM_3[21]), .B2(n72), 
        .Q(n64) );
  NAND2XL U228 ( .A(n65), .B(n64), .Q(Data_out[21]) );
  AOI22X1 U229 ( .A1(FIFO_MEM_2[26]), .A2(n71), .B1(FIFO_MEM_1[26]), .B2(n70), 
        .Q(n67) );
  AOI22X1 U230 ( .A1(FIFO_MEM_4[26]), .A2(n73), .B1(FIFO_MEM_3[26]), .B2(n72), 
        .Q(n66) );
  NAND2XL U231 ( .A(n67), .B(n66), .Q(Data_out[26]) );
  AOI22X1 U232 ( .A1(FIFO_MEM_2[28]), .A2(n71), .B1(FIFO_MEM_1[28]), .B2(n70), 
        .Q(n69) );
  AOI22X1 U233 ( .A1(FIFO_MEM_4[28]), .A2(n73), .B1(FIFO_MEM_3[28]), .B2(n72), 
        .Q(n68) );
  NAND2XL U234 ( .A(n69), .B(n68), .Q(Data_out[28]) );
  AOI22X1 U235 ( .A1(FIFO_MEM_2[23]), .A2(n71), .B1(FIFO_MEM_1[23]), .B2(n70), 
        .Q(n75) );
  AOI22X1 U236 ( .A1(FIFO_MEM_4[23]), .A2(n73), .B1(FIFO_MEM_3[23]), .B2(n72), 
        .Q(n74) );
  NAND2XL U237 ( .A(n75), .B(n74), .Q(Data_out[23]) );
  AOI22X1 U238 ( .A1(n103), .A2(read_pointer[1]), .B1(n98), .B2(
        read_pointer[0]), .Q(n76) );
  OAI221X1 U239 ( .A1(n103), .A2(read_pointer[1]), .B1(n98), .B2(
        read_pointer[0]), .C1(n76), .Q(n77) );
  AO21X1 U240 ( .A1(write_pointer[1]), .A2(n94), .B1(n83), .Q(
        write_pointer_in[1]) );
  NOR2XL U241 ( .A(write_pointer[2]), .B(write_pointer[1]), .Q(n84) );
  NAND3X1 U242 ( .A(write_pointer[3]), .B(n84), .C(n103), .Q(n80) );
  AO22X2 U243 ( .A1(n85), .A2(RX[16]), .B1(n1), .B2(FIFO_MEM_1[16]), .Q(n124)
         );
  AO22X2 U244 ( .A1(n85), .A2(RX[17]), .B1(n1), .B2(FIFO_MEM_1[17]), .Q(n123)
         );
  AO22X2 U245 ( .A1(n85), .A2(RX[21]), .B1(n1), .B2(FIFO_MEM_1[21]), .Q(n119)
         );
  AO22X2 U246 ( .A1(n85), .A2(RX[26]), .B1(n1), .B2(FIFO_MEM_1[26]), .Q(n114)
         );
  AO22X2 U247 ( .A1(n85), .A2(RX[27]), .B1(n1), .B2(FIFO_MEM_1[27]), .Q(n113)
         );
  AO22X2 U248 ( .A1(n85), .A2(RX[28]), .B1(n1), .B2(FIFO_MEM_1[28]), .Q(n112)
         );
  AO22X2 U249 ( .A1(n85), .A2(RX[18]), .B1(n1), .B2(FIFO_MEM_1[18]), .Q(n122)
         );
  AO22X2 U250 ( .A1(n85), .A2(RX[19]), .B1(n1), .B2(FIFO_MEM_1[19]), .Q(n121)
         );
  AO22X2 U251 ( .A1(n85), .A2(RX[20]), .B1(n1), .B2(FIFO_MEM_1[20]), .Q(n120)
         );
  AO22X2 U252 ( .A1(n85), .A2(RX[15]), .B1(n1), .B2(FIFO_MEM_1[15]), .Q(n125)
         );
  AO22X2 U253 ( .A1(n85), .A2(RX[22]), .B1(n1), .B2(FIFO_MEM_1[22]), .Q(n118)
         );
  AO22X2 U254 ( .A1(n85), .A2(RX[23]), .B1(n1), .B2(FIFO_MEM_1[23]), .Q(n117)
         );
  AO22X2 U255 ( .A1(n85), .A2(RX[24]), .B1(n1), .B2(FIFO_MEM_1[24]), .Q(n116)
         );
  AO22X2 U256 ( .A1(n85), .A2(RX[25]), .B1(n1), .B2(FIFO_MEM_1[25]), .Q(n115)
         );
  AO22X2 U257 ( .A1(n85), .A2(RX[29]), .B1(n1), .B2(FIFO_MEM_1[29]), .Q(n111)
         );
  NOR2XL U258 ( .A(write_pointer[3]), .B(write_pointer[0]), .Q(n87) );
  NAND3X1 U259 ( .A(n101), .B(write_pointer[1]), .C(n87), .Q(n86) );
  NAND3X1 U260 ( .A(write_pointer[2]), .B(n87), .C(n97), .Q(n88) );
  AOI22X1 U261 ( .A1(read_en), .A2(n96), .B1(n100), .B2(n93), .Q(
        read_pointer_in[0]) );
  AOI22X1 U262 ( .A1(read_en), .A2(n102), .B1(n99), .B2(n93), .Q(
        read_pointer_in[2]) );
  AOI22X1 U263 ( .A1(read_en), .A2(n99), .B1(n96), .B2(n93), .Q(
        read_pointer_in[3]) );
  INVXL U264 ( .A(n94), .Q(n95) );
  AOI22X1 U265 ( .A1(n95), .A2(n98), .B1(n103), .B2(n94), .Q(
        write_pointer_in[0]) );
  AOI22X1 U266 ( .A1(n95), .A2(n97), .B1(n101), .B2(n94), .Q(
        write_pointer_in[2]) );
  AOI22X1 U267 ( .A1(n95), .A2(n101), .B1(n98), .B2(n94), .Q(
        write_pointer_in[3]) );
endmodule


module LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_4 ( reset, clk, Rxy_reconf, 
        Reconfig, empty, flit_type, dst_addr, grant_N, grant_E, grant_W, 
        grant_S, grant_L, Req_N, Req_E, Req_W, Req_S, Req_L );
  input [7:0] Rxy_reconf;
  input [2:0] flit_type;
  input [3:0] dst_addr;
  input reset, clk, Reconfig, empty, grant_N, grant_E, grant_W, grant_S,
         grant_L;
  output Req_N, Req_E, Req_W, Req_S, Req_L;
  wire   N3, N5, ReConf_FF_out, N32, n26, n27, n28, n29, n30, n31, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23;
  wire   [7:0] Rxy;
  assign N3 = dst_addr[1];
  assign N5 = dst_addr[3];
  assign N32 = grant_E;

  DFCX1 ReConf_FF_out_reg ( .D(n53), .CP(clk), .RN(reset), .Q(ReConf_FF_out)
         );
  DFCX1 Req_E_FF_reg ( .D(n52), .CP(clk), .RN(reset), .Q(Req_E) );
  DFCX1 Req_W_FF_reg ( .D(n51), .CP(clk), .RN(reset), .Q(Req_W) );
  DFCX1 Req_S_FF_reg ( .D(n50), .CP(clk), .RN(reset), .Q(Req_S) );
  DFCX1 Req_L_FF_reg ( .D(n49), .CP(clk), .RN(reset), .Q(Req_L) );
  DFCPX1 \Rxy_reg[7]  ( .D(n31), .CP(clk), .RN(n38), .SN(n37), .Q(Rxy[7]) );
  DFCPX1 \Rxy_reg[6]  ( .D(n30), .CP(clk), .RN(n48), .SN(n47), .Q(Rxy[6]) );
  DFCPX1 \Rxy_reg[5]  ( .D(n29), .CP(clk), .RN(n46), .SN(n45), .Q(Rxy[5]) );
  DFCPX1 \Rxy_reg[4]  ( .D(n28), .CP(clk), .RN(n44), .SN(n43), .Q(Rxy[4]) );
  DFCPX1 \Rxy_reg[3]  ( .D(n27), .CP(clk), .RN(n42), .SN(n41), .Q(Rxy[3]) );
  DFCPX1 \Rxy_reg[2]  ( .D(n26), .CP(clk), .RN(n40), .SN(n39), .Q(Rxy[2]) );
  CLKINVX2 U3 ( .A(n23), .Q(n21) );
  NOR3X1 U4 ( .A(flit_type[0]), .B(n4), .C(n3), .Q(n20) );
  NAND2X1 U5 ( .A(n20), .B(ReConf_FF_out), .Q(n23) );
  AO22X1 U6 ( .A1(n21), .A2(Rxy_reconf[2]), .B1(n23), .B2(Rxy[2]), .Q(n26) );
  AO22X1 U7 ( .A1(n21), .A2(Rxy_reconf[3]), .B1(n23), .B2(Rxy[3]), .Q(n27) );
  AO22X1 U8 ( .A1(n21), .A2(Rxy_reconf[4]), .B1(n23), .B2(Rxy[4]), .Q(n28) );
  AO22X1 U9 ( .A1(n21), .A2(Rxy_reconf[5]), .B1(n23), .B2(Rxy[5]), .Q(n29) );
  AO22X1 U10 ( .A1(n21), .A2(Rxy_reconf[6]), .B1(n23), .B2(Rxy[6]), .Q(n30) );
  AO22X1 U11 ( .A1(n21), .A2(Rxy_reconf[7]), .B1(n23), .B2(Rxy[7]), .Q(n31) );
  OR2X1 U12 ( .A(Rxy_reconf[2]), .B(reset), .Q(n40) );
  OR2X1 U13 ( .A(Rxy_reconf[3]), .B(reset), .Q(n42) );
  OR2X1 U14 ( .A(Rxy_reconf[4]), .B(reset), .Q(n44) );
  OR2X1 U15 ( .A(Rxy_reconf[5]), .B(reset), .Q(n46) );
  OR2X1 U16 ( .A(Rxy_reconf[6]), .B(reset), .Q(n48) );
  OR2X1 U17 ( .A(Rxy_reconf[7]), .B(reset), .Q(n38) );
  NOR4X1 U18 ( .A(N32), .B(grant_W), .C(grant_S), .D(grant_L), .Q(n4) );
  OAI31X1 U19 ( .A1(n19), .A2(n18), .A3(n17), .B1(n16), .Q(n49) );
  OAI31X1 U20 ( .A1(n14), .A2(n12), .A3(n9), .B1(n8), .Q(n50) );
  OAI31X1 U21 ( .A1(n13), .A2(n12), .A3(n11), .B1(n10), .Q(n52) );
  OA21X1 U22 ( .A1(ReConf_FF_out), .A2(Reconfig), .B1(n23), .Q(n53) );
  NAND3X1 U23 ( .A(flit_type[0]), .B(n2), .C(n1), .Q(n12) );
  OAI31X1 U24 ( .A1(dst_addr[0]), .A2(n7), .A3(n19), .B1(n6), .Q(n51) );
  INVXL U25 ( .A(N5), .Q(n14) );
  OAI32X1 U26 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[4]), .B1(Rxy[5]), .B2(n14), 
        .Q(n7) );
  NOR2XL U27 ( .A(empty), .B(flit_type[1]), .Q(n2) );
  INVXL U28 ( .A(flit_type[2]), .Q(n1) );
  INVXL U29 ( .A(n12), .Q(n5) );
  INVXL U30 ( .A(N3), .Q(n11) );
  NAND2XL U31 ( .A(n5), .B(n11), .Q(n19) );
  NAND2XL U32 ( .A(n2), .B(flit_type[2]), .Q(n3) );
  NOR2XL U33 ( .A(n5), .B(n20), .Q(n15) );
  NAND2XL U34 ( .A(n15), .B(Req_W), .Q(n6) );
  OAI32X1 U35 ( .A1(N3), .A2(dst_addr[0]), .A3(Rxy[7]), .B1(Rxy[6]), .B2(n11), 
        .Q(n9) );
  NAND2XL U36 ( .A(n15), .B(Req_S), .Q(n8) );
  OAI32X1 U37 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[2]), .B1(Rxy[3]), .B2(n14), 
        .Q(n13) );
  NAND2XL U38 ( .A(n15), .B(Req_E), .Q(n10) );
  NAND2XL U39 ( .A(dst_addr[2]), .B(n14), .Q(n18) );
  INVXL U40 ( .A(dst_addr[0]), .Q(n17) );
  NAND2XL U41 ( .A(n15), .B(Req_L), .Q(n16) );
  INVXL U42 ( .A(reset), .Q(n22) );
  NAND2XL U43 ( .A(Rxy_reconf[6]), .B(n22), .Q(n47) );
  NAND2XL U44 ( .A(Rxy_reconf[5]), .B(n22), .Q(n45) );
  NAND2XL U45 ( .A(Rxy_reconf[4]), .B(n22), .Q(n43) );
  NAND2XL U46 ( .A(Rxy_reconf[3]), .B(n22), .Q(n41) );
  NAND2XL U47 ( .A(Rxy_reconf[2]), .B(n22), .Q(n39) );
  NAND2XL U48 ( .A(Rxy_reconf[7]), .B(n22), .Q(n37) );
endmodule


module LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_3 ( reset, clk, Rxy_reconf, 
        Reconfig, empty, flit_type, dst_addr, grant_N, grant_E, grant_W, 
        grant_S, grant_L, Req_N, Req_E, Req_W, Req_L, Req_S_BAR );
  input [7:0] Rxy_reconf;
  input [2:0] flit_type;
  input [3:0] dst_addr;
  input reset, clk, Reconfig, empty, grant_N, grant_E, grant_W, grant_S,
         grant_L;
  output Req_N, Req_E, Req_W, Req_L, Req_S_BAR;
  wire   Req_S, N3, N5, ReConf_FF_out, N32, n27, n28, n29, n30, n31, n32, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24;
  wire   [7:0] Rxy;
  assign N3 = dst_addr[1];
  assign N5 = dst_addr[3];
  assign N32 = grant_N;

  DFCX1 ReConf_FF_out_reg ( .D(n54), .CP(clk), .RN(reset), .Q(ReConf_FF_out)
         );
  DFCX1 Req_N_FF_reg ( .D(n53), .CP(clk), .RN(reset), .Q(Req_N) );
  DFCX1 Req_W_FF_reg ( .D(n52), .CP(clk), .RN(reset), .Q(Req_W) );
  DFCX1 Req_S_FF_reg ( .D(n51), .CP(clk), .RN(reset), .Q(Req_S), .QN(Req_S_BAR) );
  DFCPX1 \Rxy_reg[7]  ( .D(n32), .CP(clk), .RN(n39), .SN(n38), .Q(Rxy[7]) );
  DFCPX1 \Rxy_reg[6]  ( .D(n31), .CP(clk), .RN(n49), .SN(n48), .Q(Rxy[6]) );
  DFCPX1 \Rxy_reg[5]  ( .D(n30), .CP(clk), .RN(n47), .SN(n46), .Q(Rxy[5]) );
  DFCPX1 \Rxy_reg[4]  ( .D(n29), .CP(clk), .RN(n45), .SN(n44), .Q(Rxy[4]) );
  DFCPX1 \Rxy_reg[1]  ( .D(n28), .CP(clk), .RN(n43), .SN(n42), .Q(Rxy[1]) );
  DFCPX1 \Rxy_reg[0]  ( .D(n27), .CP(clk), .RN(n41), .SN(n40), .Q(Rxy[0]) );
  DFCX1 Req_L_FF_reg ( .D(n50), .CP(clk), .RN(reset), .Q(Req_L) );
  NAND2XL U3 ( .A(n16), .B(ReConf_FF_out), .Q(n24) );
  CLKINVX2 U4 ( .A(n24), .Q(n17) );
  OAI31X1 U5 ( .A1(n11), .A2(n10), .A3(n9), .B1(n8), .Q(n50) );
  AO22X1 U6 ( .A1(n17), .A2(Rxy_reconf[1]), .B1(n24), .B2(Rxy[1]), .Q(n28) );
  AO22X1 U7 ( .A1(n17), .A2(Rxy_reconf[4]), .B1(n24), .B2(Rxy[4]), .Q(n29) );
  AO22X1 U8 ( .A1(n17), .A2(Rxy_reconf[0]), .B1(n24), .B2(Rxy[0]), .Q(n27) );
  AO22X1 U9 ( .A1(n17), .A2(Rxy_reconf[5]), .B1(n24), .B2(Rxy[5]), .Q(n30) );
  AO22X1 U10 ( .A1(n17), .A2(Rxy_reconf[6]), .B1(n24), .B2(Rxy[6]), .Q(n31) );
  AO22X1 U11 ( .A1(n17), .A2(Rxy_reconf[7]), .B1(n24), .B2(Rxy[7]), .Q(n32) );
  NOR3X2 U12 ( .A(flit_type[0]), .B(n5), .C(n4), .Q(n16) );
  OR2X1 U13 ( .A(Rxy_reconf[0]), .B(reset), .Q(n41) );
  OR2X1 U14 ( .A(Rxy_reconf[5]), .B(reset), .Q(n47) );
  OR2X1 U15 ( .A(Rxy_reconf[6]), .B(reset), .Q(n49) );
  OR2X1 U16 ( .A(Rxy_reconf[7]), .B(reset), .Q(n39) );
  OR2X1 U17 ( .A(Rxy_reconf[4]), .B(reset), .Q(n45) );
  OR2X1 U18 ( .A(Rxy_reconf[1]), .B(reset), .Q(n43) );
  AO22X2 U19 ( .A1(n22), .A2(n21), .B1(n20), .B2(Req_W), .Q(n52) );
  NOR4X1 U20 ( .A(N32), .B(grant_W), .C(grant_S), .D(grant_L), .Q(n5) );
  OA21X1 U21 ( .A1(ReConf_FF_out), .A2(Reconfig), .B1(n24), .Q(n54) );
  NOR2XL U22 ( .A(flit_type[2]), .B(n2), .Q(n22) );
  INVXL U23 ( .A(N3), .Q(n12) );
  OAI32X1 U24 ( .A1(N3), .A2(dst_addr[0]), .A3(Rxy[1]), .B1(Rxy[0]), .B2(n12), 
        .Q(n7) );
  NOR2X3 U25 ( .A(empty), .B(flit_type[1]), .Q(n3) );
  NAND2XL U26 ( .A(flit_type[0]), .B(n3), .Q(n2) );
  INVXL U27 ( .A(N5), .Q(n18) );
  NAND2XL U28 ( .A(n22), .B(n18), .Q(n10) );
  NAND2XL U29 ( .A(n3), .B(flit_type[2]), .Q(n4) );
  NOR2X3 U30 ( .A(n22), .B(n16), .Q(n20) );
  NAND2XL U31 ( .A(n20), .B(Req_N), .Q(n6) );
  OAI31X2 U32 ( .A1(dst_addr[2]), .A2(n7), .A3(n10), .B1(n6), .Q(n53) );
  INVXL U33 ( .A(dst_addr[2]), .Q(n11) );
  NAND2XL U34 ( .A(dst_addr[0]), .B(n12), .Q(n9) );
  NAND2XL U35 ( .A(n20), .B(Req_L), .Q(n8) );
  OAI32X1 U36 ( .A1(N3), .A2(dst_addr[0]), .A3(Rxy[7]), .B1(Rxy[6]), .B2(n12), 
        .Q(n15) );
  INVXL U37 ( .A(n22), .Q(n14) );
  NAND2XL U38 ( .A(n20), .B(Req_S), .Q(n13) );
  OAI31X2 U39 ( .A1(n15), .A2(n14), .A3(n18), .B1(n13), .Q(n51) );
  OAI32X1 U40 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[4]), .B1(Rxy[5]), .B2(n18), 
        .Q(n19) );
  NOR3X3 U41 ( .A(N3), .B(dst_addr[0]), .C(n19), .Q(n21) );
  INVXL U42 ( .A(reset), .Q(n23) );
  NAND2XL U43 ( .A(Rxy_reconf[6]), .B(n23), .Q(n48) );
  NAND2XL U44 ( .A(Rxy_reconf[5]), .B(n23), .Q(n46) );
  NAND2XL U45 ( .A(Rxy_reconf[4]), .B(n23), .Q(n44) );
  NAND2XL U46 ( .A(Rxy_reconf[1]), .B(n23), .Q(n42) );
  NAND2XL U47 ( .A(Rxy_reconf[0]), .B(n23), .Q(n40) );
  NAND2XL U48 ( .A(Rxy_reconf[7]), .B(n23), .Q(n38) );
endmodule


module LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_2 ( reset, clk, Rxy_reconf, 
        Reconfig, empty, flit_type, dst_addr, grant_N, grant_E, grant_W, 
        grant_S, grant_L, Req_N, Req_E, Req_W, Req_L, Req_S_BAR );
  input [7:0] Rxy_reconf;
  input [2:0] flit_type;
  input [3:0] dst_addr;
  input reset, clk, Reconfig, empty, grant_N, grant_E, grant_W, grant_S,
         grant_L;
  output Req_N, Req_E, Req_W, Req_L, Req_S_BAR;
  wire   Req_S, N3, N5, ReConf_FF_out, n26, n27, n28, n29, n30, n31, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23;
  wire   [7:0] Rxy;
  assign N3 = dst_addr[1];
  assign N5 = dst_addr[3];

  DFCX1 ReConf_FF_out_reg ( .D(n53), .CP(clk), .RN(reset), .Q(ReConf_FF_out)
         );
  DFCX1 Req_N_FF_reg ( .D(n52), .CP(clk), .RN(reset), .Q(Req_N) );
  DFCX1 Req_E_FF_reg ( .D(n51), .CP(clk), .RN(reset), .Q(Req_E) );
  DFCX1 Req_S_FF_reg ( .D(n50), .CP(clk), .RN(reset), .Q(Req_S), .QN(Req_S_BAR) );
  DFCX1 Req_L_FF_reg ( .D(n49), .CP(clk), .RN(reset), .Q(Req_L) );
  DFCPX1 \Rxy_reg[7]  ( .D(n31), .CP(clk), .RN(n38), .SN(n37), .Q(Rxy[7]) );
  DFCPX1 \Rxy_reg[6]  ( .D(n30), .CP(clk), .RN(n48), .SN(n47), .Q(Rxy[6]) );
  DFCPX1 \Rxy_reg[3]  ( .D(n29), .CP(clk), .RN(n46), .SN(n45), .Q(Rxy[3]) );
  DFCPX1 \Rxy_reg[2]  ( .D(n28), .CP(clk), .RN(n44), .SN(n43), .Q(Rxy[2]) );
  DFCPX1 \Rxy_reg[1]  ( .D(n27), .CP(clk), .RN(n42), .SN(n41), .Q(Rxy[1]) );
  DFCPX1 \Rxy_reg[0]  ( .D(n26), .CP(clk), .RN(n40), .SN(n39), .Q(Rxy[0]) );
  INVXL U3 ( .A(n23), .Q(n21) );
  NAND2X1 U4 ( .A(n20), .B(ReConf_FF_out), .Q(n23) );
  AO22X1 U5 ( .A1(n21), .A2(Rxy_reconf[0]), .B1(n23), .B2(Rxy[0]), .Q(n26) );
  AO22X1 U6 ( .A1(n21), .A2(Rxy_reconf[1]), .B1(n23), .B2(Rxy[1]), .Q(n27) );
  AO22X1 U7 ( .A1(n21), .A2(Rxy_reconf[2]), .B1(n23), .B2(Rxy[2]), .Q(n28) );
  AO22X1 U8 ( .A1(n21), .A2(Rxy_reconf[3]), .B1(n23), .B2(Rxy[3]), .Q(n29) );
  AO22X1 U9 ( .A1(n21), .A2(Rxy_reconf[6]), .B1(n23), .B2(Rxy[6]), .Q(n30) );
  AO22X1 U10 ( .A1(n21), .A2(Rxy_reconf[7]), .B1(n23), .B2(Rxy[7]), .Q(n31) );
  NOR3X2 U11 ( .A(flit_type[0]), .B(n4), .C(n3), .Q(n20) );
  OR2X1 U12 ( .A(Rxy_reconf[0]), .B(reset), .Q(n40) );
  OR2X1 U13 ( .A(Rxy_reconf[1]), .B(reset), .Q(n42) );
  OR2X1 U14 ( .A(Rxy_reconf[2]), .B(reset), .Q(n44) );
  OR2X1 U15 ( .A(Rxy_reconf[3]), .B(reset), .Q(n46) );
  OR2X1 U16 ( .A(Rxy_reconf[6]), .B(reset), .Q(n48) );
  OR2X1 U17 ( .A(Rxy_reconf[7]), .B(reset), .Q(n38) );
  OAI31X1 U18 ( .A1(n14), .A2(n18), .A3(n13), .B1(n12), .Q(n49) );
  OAI31X1 U19 ( .A1(n6), .A2(n9), .A3(n10), .B1(n5), .Q(n50) );
  OAI31X1 U20 ( .A1(n15), .A2(n9), .A3(n8), .B1(n7), .Q(n51) );
  OA21X1 U21 ( .A1(ReConf_FF_out), .A2(Reconfig), .B1(n23), .Q(n53) );
  NOR4X1 U22 ( .A(grant_N), .B(grant_E), .C(grant_S), .D(grant_L), .Q(n4) );
  OAI31X1 U23 ( .A1(dst_addr[2]), .A2(n19), .A3(n18), .B1(n17), .Q(n52) );
  INVXL U24 ( .A(N3), .Q(n15) );
  OAI32X1 U25 ( .A1(N3), .A2(dst_addr[0]), .A3(Rxy[7]), .B1(Rxy[6]), .B2(n15), 
        .Q(n6) );
  NOR2XL U26 ( .A(empty), .B(flit_type[1]), .Q(n2) );
  NAND2XL U27 ( .A(flit_type[0]), .B(n2), .Q(n1) );
  NOR2XL U28 ( .A(flit_type[2]), .B(n1), .Q(n11) );
  INVXL U29 ( .A(n11), .Q(n9) );
  INVXL U30 ( .A(N5), .Q(n10) );
  NAND2XL U31 ( .A(n2), .B(flit_type[2]), .Q(n3) );
  NOR2XL U32 ( .A(n11), .B(n20), .Q(n16) );
  NAND2XL U33 ( .A(n16), .B(Req_S), .Q(n5) );
  OAI32X1 U34 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[2]), .B1(Rxy[3]), .B2(n10), 
        .Q(n8) );
  NAND2XL U35 ( .A(n16), .B(Req_E), .Q(n7) );
  INVXL U36 ( .A(dst_addr[2]), .Q(n14) );
  NAND2XL U37 ( .A(n11), .B(n10), .Q(n18) );
  NAND2XL U38 ( .A(dst_addr[0]), .B(n15), .Q(n13) );
  NAND2XL U39 ( .A(n16), .B(Req_L), .Q(n12) );
  OAI32X1 U40 ( .A1(N3), .A2(dst_addr[0]), .A3(Rxy[1]), .B1(Rxy[0]), .B2(n15), 
        .Q(n19) );
  NAND2XL U41 ( .A(n16), .B(Req_N), .Q(n17) );
  INVXL U42 ( .A(reset), .Q(n22) );
  NAND2XL U43 ( .A(Rxy_reconf[6]), .B(n22), .Q(n47) );
  NAND2XL U44 ( .A(Rxy_reconf[3]), .B(n22), .Q(n45) );
  NAND2XL U45 ( .A(Rxy_reconf[2]), .B(n22), .Q(n43) );
  NAND2XL U46 ( .A(Rxy_reconf[1]), .B(n22), .Q(n41) );
  NAND2XL U47 ( .A(Rxy_reconf[0]), .B(n22), .Q(n39) );
  NAND2XL U48 ( .A(Rxy_reconf[7]), .B(n22), .Q(n37) );
endmodule


module LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_1 ( reset, clk, Rxy_reconf, 
        Reconfig, empty, flit_type, dst_addr, grant_N, grant_E, grant_W, 
        grant_S, grant_L, Req_N, Req_E, Req_W, Req_S, Req_L );
  input [7:0] Rxy_reconf;
  input [2:0] flit_type;
  input [3:0] dst_addr;
  input reset, clk, Reconfig, empty, grant_N, grant_E, grant_W, grant_S,
         grant_L;
  output Req_N, Req_E, Req_W, Req_S, Req_L;
  wire   N3, N5, ReConf_FF_out, n27, n28, n29, n30, n31, n32, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26;
  wire   [7:0] Rxy;
  assign N3 = dst_addr[1];
  assign N5 = dst_addr[3];

  DFCX1 ReConf_FF_out_reg ( .D(n54), .CP(clk), .RN(reset), .Q(ReConf_FF_out)
         );
  DFCX1 Req_W_FF_reg ( .D(n51), .CP(clk), .RN(reset), .Q(Req_W) );
  DFCPX1 \Rxy_reg[5]  ( .D(n32), .CP(clk), .RN(n49), .SN(n48), .Q(Rxy[5]) );
  DFCPX1 \Rxy_reg[4]  ( .D(n31), .CP(clk), .RN(n47), .SN(n46), .Q(Rxy[4]) );
  DFCPX1 \Rxy_reg[3]  ( .D(n30), .CP(clk), .RN(n45), .SN(n44), .Q(Rxy[3]) );
  DFCPX1 \Rxy_reg[2]  ( .D(n29), .CP(clk), .RN(n43), .SN(n42), .Q(Rxy[2]) );
  DFCPX1 \Rxy_reg[1]  ( .D(n28), .CP(clk), .RN(n41), .SN(n40), .Q(Rxy[1]) );
  DFCPX1 \Rxy_reg[0]  ( .D(n27), .CP(clk), .RN(n39), .SN(n38), .QN(n26) );
  DFCX1 Req_E_FF_reg ( .D(n52), .CP(clk), .RN(reset), .Q(Req_E) );
  DFCX1 Req_L_FF_reg ( .D(n50), .CP(clk), .RN(reset), .Q(Req_L) );
  DFCX1 Req_N_FF_reg ( .D(n53), .CP(clk), .RN(reset), .Q(Req_N) );
  OAI31X1 U3 ( .A1(n16), .A2(n15), .A3(n20), .B1(n14), .Q(n50) );
  OR2X1 U4 ( .A(Rxy_reconf[3]), .B(reset), .Q(n45) );
  OR2X1 U5 ( .A(Rxy_reconf[4]), .B(reset), .Q(n47) );
  OR2X1 U6 ( .A(Rxy_reconf[5]), .B(reset), .Q(n49) );
  OR2X1 U7 ( .A(Rxy_reconf[1]), .B(reset), .Q(n41) );
  OR2X1 U8 ( .A(Rxy_reconf[2]), .B(reset), .Q(n43) );
  AO22X2 U9 ( .A1(n22), .A2(Rxy_reconf[1]), .B1(n25), .B2(Rxy[1]), .Q(n28) );
  AO22X2 U10 ( .A1(n22), .A2(Rxy_reconf[2]), .B1(n25), .B2(Rxy[2]), .Q(n29) );
  AO22X2 U11 ( .A1(n22), .A2(Rxy_reconf[3]), .B1(n25), .B2(Rxy[3]), .Q(n30) );
  AO22X2 U12 ( .A1(n22), .A2(Rxy_reconf[4]), .B1(n25), .B2(Rxy[4]), .Q(n31) );
  AO22X2 U13 ( .A1(n22), .A2(Rxy_reconf[5]), .B1(n25), .B2(Rxy[5]), .Q(n32) );
  NOR4X1 U14 ( .A(grant_N), .B(grant_E), .C(grant_W), .D(grant_L), .Q(n2) );
  OAI21X1 U15 ( .A1(n8), .A2(n10), .B1(n7), .Q(n53) );
  OAI31X1 U16 ( .A1(N3), .A2(Rxy[1]), .A3(dst_addr[0]), .B1(n3), .Q(n8) );
  AOI22X1 U17 ( .A1(n22), .A2(n23), .B1(n26), .B2(n25), .Q(n27) );
  OA21X1 U18 ( .A1(ReConf_FF_out), .A2(Reconfig), .B1(n25), .Q(n54) );
  NOR2XL U19 ( .A(empty), .B(flit_type[1]), .Q(n5) );
  NAND2XL U20 ( .A(n5), .B(flit_type[2]), .Q(n1) );
  NOR3X3 U21 ( .A(flit_type[0]), .B(n2), .C(n1), .Q(n6) );
  NAND2X3 U22 ( .A(n6), .B(ReConf_FF_out), .Q(n25) );
  CLKINVX2 U23 ( .A(n25), .Q(n22) );
  INVXL U24 ( .A(Rxy_reconf[0]), .Q(n23) );
  AOI211X1 U25 ( .A1(N3), .A2(n26), .B1(dst_addr[2]), .C1(N5), .Q(n3) );
  INVXL U26 ( .A(flit_type[2]), .Q(n4) );
  NAND3X3 U27 ( .A(flit_type[0]), .B(n5), .C(n4), .Q(n10) );
  INVXL U28 ( .A(n10), .Q(n13) );
  NOR2XL U29 ( .A(n13), .B(n6), .Q(n18) );
  NAND2XL U30 ( .A(n18), .B(Req_N), .Q(n7) );
  INVXL U31 ( .A(N5), .Q(n17) );
  OAI32X1 U32 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[2]), .B1(Rxy[3]), .B2(n17), 
        .Q(n11) );
  INVXL U33 ( .A(N3), .Q(n12) );
  NAND2XL U34 ( .A(n18), .B(Req_E), .Q(n9) );
  OAI31X2 U35 ( .A1(n11), .A2(n12), .A3(n10), .B1(n9), .Q(n52) );
  NAND2XL U36 ( .A(dst_addr[2]), .B(n17), .Q(n16) );
  INVXL U37 ( .A(dst_addr[0]), .Q(n15) );
  NAND2XL U38 ( .A(n13), .B(n12), .Q(n20) );
  NAND2XL U39 ( .A(n18), .B(Req_L), .Q(n14) );
  OAI32X1 U40 ( .A1(N5), .A2(dst_addr[2]), .A3(Rxy[4]), .B1(Rxy[5]), .B2(n17), 
        .Q(n21) );
  NAND2XL U41 ( .A(n18), .B(Req_W), .Q(n19) );
  OAI31X2 U42 ( .A1(dst_addr[0]), .A2(n21), .A3(n20), .B1(n19), .Q(n51) );
  INVXL U43 ( .A(reset), .Q(n24) );
  NAND2XL U44 ( .A(Rxy_reconf[5]), .B(n24), .Q(n48) );
  NAND2XL U45 ( .A(Rxy_reconf[4]), .B(n24), .Q(n46) );
  NAND2XL U46 ( .A(Rxy_reconf[3]), .B(n24), .Q(n44) );
  NAND2XL U47 ( .A(Rxy_reconf[2]), .B(n24), .Q(n42) );
  NAND2XL U48 ( .A(Rxy_reconf[1]), .B(n24), .Q(n40) );
  NAND2XL U49 ( .A(n23), .B(n24), .Q(n39) );
  NAND2XL U50 ( .A(Rxy_reconf[0]), .B(n24), .Q(n38) );
endmodule


module LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_0 ( reset, clk, Rxy_reconf, 
        Reconfig, empty, flit_type, dst_addr, grant_N, grant_E, grant_W, 
        grant_S, grant_L, Req_N, Req_E, Req_W, Req_S, Req_L );
  input [7:0] Rxy_reconf;
  input [2:0] flit_type;
  input [3:0] dst_addr;
  input reset, clk, Reconfig, empty, grant_N, grant_E, grant_W, grant_S,
         grant_L;
  output Req_N, Req_E, Req_W, Req_S, Req_L;
  wire   N3, N5, ReConf_FF_out, n26, n27, n28, n29, n30, n31, n32, n33, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57, n58, n59, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23;
  wire   [7:0] Rxy;
  assign N3 = dst_addr[1];
  assign N5 = dst_addr[3];

  DFCX1 ReConf_FF_out_reg ( .D(n59), .CP(clk), .RN(reset), .Q(ReConf_FF_out)
         );
  DFCX1 Req_E_FF_reg ( .D(n57), .CP(clk), .RN(reset), .Q(Req_E) );
  DFCX1 Req_W_FF_reg ( .D(n56), .CP(clk), .RN(reset), .Q(Req_W) );
  DFCX1 Req_S_FF_reg ( .D(n55), .CP(clk), .RN(reset), .Q(Req_S) );
  DFCPX1 \Rxy_reg[7]  ( .D(n33), .CP(clk), .RN(n40), .SN(n39), .Q(Rxy[7]) );
  DFCPX1 \Rxy_reg[6]  ( .D(n32), .CP(clk), .RN(n54), .SN(n53), .Q(Rxy[6]) );
  DFCPX1 \Rxy_reg[5]  ( .D(n31), .CP(clk), .RN(n52), .SN(n51), .Q(Rxy[5]) );
  DFCPX1 \Rxy_reg[4]  ( .D(n30), .CP(clk), .RN(n50), .SN(n49), .Q(Rxy[4]) );
  DFCPX1 \Rxy_reg[3]  ( .D(n29), .CP(clk), .RN(n48), .SN(n47), .Q(Rxy[3]) );
  DFCPX1 \Rxy_reg[2]  ( .D(n28), .CP(clk), .RN(n46), .SN(n45), .Q(Rxy[2]) );
  DFCPX1 \Rxy_reg[1]  ( .D(n27), .CP(clk), .RN(n44), .SN(n43), .Q(Rxy[1]) );
  DFCPX1 \Rxy_reg[0]  ( .D(n26), .CP(clk), .RN(n42), .SN(n41), .Q(Rxy[0]) );
  DFCX1 Req_N_FF_reg ( .D(n58), .CP(clk), .RN(reset), .Q(Req_N) );
  NOR4X1 U3 ( .A(grant_N), .B(grant_E), .C(grant_W), .D(grant_S), .Q(n4) );
  NOR3X1 U4 ( .A(flit_type[0]), .B(n4), .C(n3), .Q(n20) );
  AO22X1 U5 ( .A1(n21), .A2(Rxy_reconf[7]), .B1(n23), .B2(Rxy[7]), .Q(n33) );
  AO22X1 U6 ( .A1(n21), .A2(Rxy_reconf[6]), .B1(n23), .B2(Rxy[6]), .Q(n32) );
  AO22X1 U7 ( .A1(n21), .A2(Rxy_reconf[0]), .B1(n23), .B2(Rxy[0]), .Q(n26) );
  AO22X1 U8 ( .A1(n21), .A2(Rxy_reconf[5]), .B1(n23), .B2(Rxy[5]), .Q(n31) );
  AO22X1 U9 ( .A1(n21), .A2(Rxy_reconf[1]), .B1(n23), .B2(Rxy[1]), .Q(n27) );
  AO22X1 U10 ( .A1(n21), .A2(Rxy_reconf[2]), .B1(n23), .B2(Rxy[2]), .Q(n28) );
  AO22X1 U11 ( .A1(n21), .A2(Rxy_reconf[3]), .B1(n23), .B2(Rxy[3]), .Q(n29) );
  AO22X1 U12 ( .A1(n21), .A2(Rxy_reconf[4]), .B1(n23), .B2(Rxy[4]), .Q(n30) );
  OR2X1 U13 ( .A(Rxy_reconf[3]), .B(reset), .Q(n48) );
  OR2X1 U14 ( .A(Rxy_reconf[4]), .B(reset), .Q(n50) );
  OR2X1 U15 ( .A(Rxy_reconf[1]), .B(reset), .Q(n44) );
  OR2X1 U16 ( .A(Rxy_reconf[5]), .B(reset), .Q(n52) );
  OR2X1 U17 ( .A(Rxy_reconf[6]), .B(reset), .Q(n54) );
  OR2X1 U18 ( .A(Rxy_reconf[7]), .B(reset), .Q(n40) );
  OR2X1 U19 ( .A(Rxy_reconf[0]), .B(reset), .Q(n42) );
  OR2X1 U20 ( .A(Rxy_reconf[2]), .B(reset), .Q(n46) );
  NAND2X3 U21 ( .A(n20), .B(ReConf_FF_out), .Q(n23) );
  OR2X1 U22 ( .A(N5), .B(dst_addr[2]), .Q(n19) );
  CLKINVX2 U23 ( .A(n23), .Q(n21) );
  OR2X1 U24 ( .A(N3), .B(dst_addr[0]), .Q(n13) );
  OAI31X1 U25 ( .A1(n19), .A2(n18), .A3(n17), .B1(n16), .Q(n58) );
  OAI31X1 U26 ( .A1(n10), .A2(n18), .A3(n7), .B1(n6), .Q(n55) );
  OAI31X1 U27 ( .A1(n13), .A2(n18), .A3(n12), .B1(n11), .Q(n56) );
  OAI31X1 U28 ( .A1(n14), .A2(n18), .A3(n9), .B1(n8), .Q(n57) );
  OA21X1 U29 ( .A1(ReConf_FF_out), .A2(Reconfig), .B1(n23), .Q(n59) );
  INVXL U30 ( .A(N5), .Q(n10) );
  NOR2XL U31 ( .A(empty), .B(flit_type[1]), .Q(n2) );
  INVXL U32 ( .A(flit_type[2]), .Q(n1) );
  NAND3X3 U33 ( .A(flit_type[0]), .B(n2), .C(n1), .Q(n18) );
  INVXL U34 ( .A(N3), .Q(n14) );
  OAI22X1 U35 ( .A1(Rxy[6]), .A2(n14), .B1(Rxy[7]), .B2(n13), .Q(n7) );
  INVXL U36 ( .A(n18), .Q(n5) );
  NAND2XL U37 ( .A(n2), .B(flit_type[2]), .Q(n3) );
  NOR2XL U38 ( .A(n5), .B(n20), .Q(n15) );
  NAND2XL U39 ( .A(n15), .B(Req_S), .Q(n6) );
  OAI22X1 U40 ( .A1(Rxy[3]), .A2(n10), .B1(Rxy[2]), .B2(n19), .Q(n9) );
  NAND2XL U41 ( .A(n15), .B(Req_E), .Q(n8) );
  OAI22X1 U42 ( .A1(Rxy[5]), .A2(n10), .B1(Rxy[4]), .B2(n19), .Q(n12) );
  NAND2XL U43 ( .A(n15), .B(Req_W), .Q(n11) );
  OAI32X1 U44 ( .A1(N3), .A2(Rxy[1]), .A3(dst_addr[0]), .B1(Rxy[0]), .B2(n14), 
        .Q(n17) );
  NAND2XL U45 ( .A(n15), .B(Req_N), .Q(n16) );
  INVXL U46 ( .A(reset), .Q(n22) );
  NAND2XL U47 ( .A(Rxy_reconf[6]), .B(n22), .Q(n53) );
  NAND2XL U48 ( .A(Rxy_reconf[5]), .B(n22), .Q(n51) );
  NAND2XL U49 ( .A(Rxy_reconf[4]), .B(n22), .Q(n49) );
  NAND2XL U50 ( .A(Rxy_reconf[3]), .B(n22), .Q(n47) );
  NAND2XL U51 ( .A(Rxy_reconf[2]), .B(n22), .Q(n45) );
  NAND2XL U52 ( .A(Rxy_reconf[1]), .B(n22), .Q(n43) );
  NAND2XL U53 ( .A(Rxy_reconf[0]), .B(n22), .Q(n41) );
  NAND2XL U54 ( .A(Rxy_reconf[7]), .B(n22), .Q(n39) );
endmodule


module arbiter_in_4 ( reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L, 
        X_N, X_E, X_W, X_S, X_L );
  input reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L;
  output X_N, X_E, X_W, X_S, X_L;
  wire   N54, n44, n45, n46, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n47, n48, n49, n50, n51;
  wire   [2:0] state;
  assign N54 = Req_X_L;

  DFCX1 \state_reg[2]  ( .D(n44), .CP(clk), .RN(reset), .Q(state[2]), .QN(n51)
         );
  DFCX1 \state_reg[0]  ( .D(n46), .CP(clk), .RN(reset), .Q(state[0]) );
  DFCX1 \state_reg[1]  ( .D(n45), .CP(clk), .RN(reset), .Q(state[1]) );
  NAND2X1 U3 ( .A(n21), .B(n42), .Q(n22) );
  AOI31X2 U4 ( .A1(N54), .A2(n30), .A3(n29), .B1(n28), .Q(n31) );
  AOI21X2 U5 ( .A1(n43), .A2(n14), .B1(n42), .Q(n15) );
  OAI21X2 U6 ( .A1(n43), .A2(n42), .B1(n29), .Q(n17) );
  AOI21X1 U7 ( .A1(n37), .A2(n22), .B1(n26), .Q(X_E) );
  NOR2X1 U8 ( .A(state[2]), .B(n12), .Q(n35) );
  AOI21X1 U9 ( .A1(n37), .A2(n47), .B1(Req_X_E), .Q(n19) );
  AOI21X1 U10 ( .A1(n24), .A2(n16), .B1(n23), .Q(n37) );
  OA21X1 U11 ( .A1(n27), .A2(n29), .B1(n26), .Q(n28) );
  OAI31X1 U12 ( .A1(state[1]), .A2(state[0]), .A3(n51), .B1(n13), .Q(n42) );
  NOR2XL U13 ( .A(n35), .B(n19), .Q(n20) );
  OAI21X1 U14 ( .A1(state[1]), .A2(state[0]), .B1(state[2]), .Q(n18) );
  NOR2XL U15 ( .A(Req_X_W), .B(Req_X_E), .Q(n43) );
  INVXL U16 ( .A(n18), .Q(n24) );
  INVXL U17 ( .A(N54), .Q(n16) );
  AOI21X1 U18 ( .A1(state[1]), .A2(state[0]), .B1(state[2]), .Q(n23) );
  INVXL U19 ( .A(n37), .Q(n14) );
  NAND2XL U20 ( .A(state[1]), .B(state[0]), .Q(n12) );
  INVXL U21 ( .A(Req_X_W), .Q(n25) );
  NAND2XL U22 ( .A(n35), .B(n25), .Q(n13) );
  INVXL U23 ( .A(Req_X_S), .Q(n29) );
  NOR2X3 U24 ( .A(n15), .B(n29), .Q(X_S) );
  AOI21X3 U25 ( .A1(n18), .A2(n17), .B1(n16), .Q(X_L) );
  NOR2XL U26 ( .A(N54), .B(Req_X_S), .Q(n21) );
  INVXL U27 ( .A(n21), .Q(n47) );
  NOR2X3 U28 ( .A(n20), .B(n25), .Q(X_W) );
  INVXL U29 ( .A(Req_X_E), .Q(n26) );
  INVXL U30 ( .A(n43), .Q(n41) );
  NOR2XL U31 ( .A(n47), .B(n41), .Q(n34) );
  NAND2XL U32 ( .A(N54), .B(n24), .Q(n50) );
  INVXL U33 ( .A(n50), .Q(n33) );
  NOR2XL U34 ( .A(n24), .B(n23), .Q(n30) );
  NOR2XL U35 ( .A(n25), .B(n30), .Q(n27) );
  NOR2XL U36 ( .A(n31), .B(n34), .Q(n32) );
  AOI211X1 U37 ( .A1(n34), .A2(state[0]), .B1(n33), .C1(n32), .Q(n36) );
  NAND2XL U38 ( .A(Req_X_W), .B(n35), .Q(n40) );
  NAND2XL U39 ( .A(n36), .B(n40), .Q(n46) );
  OAI21X1 U40 ( .A1(n43), .A2(n37), .B1(n47), .Q(n38) );
  OAI21X1 U41 ( .A1(state[1]), .A2(n41), .B1(n38), .Q(n39) );
  NAND2XL U42 ( .A(n40), .B(n39), .Q(n45) );
  NOR2XL U43 ( .A(n51), .B(n41), .Q(n48) );
  OAI22X1 U44 ( .A1(n48), .A2(n47), .B1(n43), .B2(n42), .Q(n49) );
  NAND2XL U45 ( .A(n50), .B(n49), .Q(n44) );
endmodule


module arbiter_in_3 ( reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_L, X_N, X_E, 
        X_W, X_S, X_L, Req_X_S_BAR );
  input reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_L, Req_X_S_BAR;
  output X_N, X_E, X_W, X_S, X_L;
  wire   Req_X_S, n43, n44, n45, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35;
  wire   [2:0] state;
  assign Req_X_S = Req_X_S_BAR;

  DFCX1 \state_reg[0]  ( .D(n45), .CP(clk), .RN(reset), .Q(state[0]) );
  DFCX1 \state_reg[2]  ( .D(n43), .CP(clk), .RN(reset), .Q(state[2]) );
  DFCX1 \state_reg[1]  ( .D(n44), .CP(clk), .RN(reset), .Q(state[1]), .QN(n35)
         );
  NOR2XL U3 ( .A(n13), .B(Req_X_S), .Q(X_S) );
  NOR2X2 U4 ( .A(Req_X_W), .B(Req_X_N), .Q(n31) );
  OR2X1 U5 ( .A(state[1]), .B(state[2]), .Q(n19) );
  CLKINVX1 U6 ( .A(n15), .Q(X_W) );
  AO22X2 U7 ( .A1(n12), .A2(n21), .B1(n11), .B2(state[2]), .Q(n30) );
  OAI21X2 U8 ( .A1(state[1]), .A2(state[0]), .B1(state[2]), .Q(n34) );
  AOI21X1 U9 ( .A1(n34), .A2(n33), .B1(n32), .Q(X_L) );
  OAI21X1 U10 ( .A1(n31), .A2(n30), .B1(Req_X_S), .Q(n33) );
  AOI21X1 U11 ( .A1(n31), .A2(n26), .B1(n30), .Q(n13) );
  OAI21X1 U12 ( .A1(Req_X_L), .A2(n34), .B1(n19), .Q(n26) );
  INVXL U13 ( .A(n16), .Q(n27) );
  NOR2XL U14 ( .A(n29), .B(n28), .Q(X_N) );
  AOI21X1 U15 ( .A1(n27), .A2(n30), .B1(n26), .Q(n29) );
  OAI21X1 U16 ( .A1(n21), .A2(n14), .B1(Req_X_W), .Q(n15) );
  OA21X1 U17 ( .A1(n27), .A2(n26), .B1(n28), .Q(n14) );
  OAI21X1 U18 ( .A1(n18), .A2(n17), .B1(n23), .Q(n43) );
  INVXL U19 ( .A(Req_X_W), .Q(n12) );
  NOR2XL U20 ( .A(n35), .B(state[2]), .Q(n21) );
  NOR2XL U21 ( .A(state[1]), .B(state[0]), .Q(n11) );
  INVXL U22 ( .A(Req_X_L), .Q(n32) );
  NAND2XL U23 ( .A(n32), .B(Req_X_S), .Q(n16) );
  INVXL U24 ( .A(Req_X_N), .Q(n28) );
  NAND2XL U25 ( .A(n27), .B(n31), .Q(n22) );
  OAI21X1 U26 ( .A1(n35), .A2(n22), .B1(n15), .Q(n44) );
  AOI21X1 U27 ( .A1(n16), .A2(n30), .B1(n31), .Q(n18) );
  NOR2XL U28 ( .A(n22), .B(state[2]), .Q(n17) );
  OR2X1 U29 ( .A(n32), .B(n34), .Q(n23) );
  AOI21X1 U30 ( .A1(n34), .A2(n19), .B1(n31), .Q(n20) );
  AOI211X1 U31 ( .A1(Req_X_W), .A2(n21), .B1(n20), .C1(Req_X_S), .Q(n25) );
  NOR2XL U32 ( .A(n22), .B(state[0]), .Q(n24) );
  OAI21X1 U33 ( .A1(n25), .A2(n24), .B1(n23), .Q(n45) );
endmodule


module arbiter_in_2 ( reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_L, X_N, X_E, 
        X_W, X_S, X_L, Req_X_S_BAR );
  input reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_L, Req_X_S_BAR;
  output X_N, X_E, X_W, X_S, X_L;
  wire   Req_X_S, n46, n47, n48, n11, n12, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43;
  wire   [2:0] state;
  assign Req_X_S = Req_X_S_BAR;

  DFCX1 \state_reg[2]  ( .D(n46), .CP(clk), .RN(reset), .Q(state[2]), .QN(n43)
         );
  DFCX1 \state_reg[0]  ( .D(n48), .CP(clk), .RN(reset), .Q(state[0]), .QN(n42)
         );
  DFCX1 \state_reg[1]  ( .D(n47), .CP(clk), .RN(reset), .Q(state[1]) );
  NOR2XL U3 ( .A(Req_X_L), .B(n22), .Q(n39) );
  NOR2XL U4 ( .A(n23), .B(n38), .Q(n29) );
  AOI21X1 U5 ( .A1(n23), .A2(n37), .B1(n38), .Q(n13) );
  NOR2X2 U6 ( .A(n41), .B(n40), .Q(X_N) );
  OAI21X2 U7 ( .A1(Req_X_E), .A2(n30), .B1(n12), .Q(n38) );
  INVX2 U8 ( .A(n17), .Q(n12) );
  NOR2X1 U9 ( .A(state[1]), .B(state[0]), .Q(n11) );
  OAI21X1 U10 ( .A1(n42), .A2(n30), .B1(n19), .Q(n17) );
  AOI21X1 U11 ( .A1(n39), .A2(n38), .B1(n37), .Q(n41) );
  OAI31X1 U12 ( .A1(n29), .A2(n22), .A3(n14), .B1(n27), .Q(X_L) );
  NOR2XL U13 ( .A(Req_X_S), .B(n13), .Q(X_S) );
  NOR2XL U14 ( .A(Req_X_E), .B(Req_X_N), .Q(n23) );
  NOR2XL U15 ( .A(n43), .B(n11), .Q(n16) );
  INVXL U16 ( .A(Req_X_L), .Q(n14) );
  NOR2XL U17 ( .A(state[2]), .B(state[1]), .Q(n15) );
  AO21X3 U18 ( .A1(n16), .A2(n14), .B1(n15), .Q(n37) );
  NAND2XL U19 ( .A(state[1]), .B(n43), .Q(n30) );
  NAND2XL U20 ( .A(state[2]), .B(n11), .Q(n19) );
  INVXL U21 ( .A(Req_X_S), .Q(n22) );
  NAND2XL U22 ( .A(Req_X_L), .B(n16), .Q(n27) );
  OAI21X1 U23 ( .A1(n16), .A2(n15), .B1(Req_X_N), .Q(n26) );
  INVXL U24 ( .A(Req_X_N), .Q(n40) );
  AOI22X1 U25 ( .A1(Req_X_L), .A2(n17), .B1(Req_X_N), .B2(state[0]), .Q(n18)
         );
  OAI211X1 U26 ( .A1(n19), .A2(n40), .B1(Req_X_E), .C1(n18), .Q(n21) );
  INVXL U27 ( .A(n27), .Q(n20) );
  AOI21X1 U28 ( .A1(Req_X_S), .A2(n21), .B1(n20), .Q(n25) );
  NAND2XL U29 ( .A(n39), .B(n23), .Q(n33) );
  INVXL U30 ( .A(n33), .Q(n24) );
  AOI22X1 U31 ( .A1(n26), .A2(n25), .B1(n42), .B2(n24), .Q(n48) );
  OA21X1 U32 ( .A1(n33), .A2(n43), .B1(n27), .Q(n28) );
  OAI21X1 U33 ( .A1(n39), .A2(n29), .B1(n28), .Q(n46) );
  INVXL U34 ( .A(n30), .Q(n31) );
  NAND3X1 U35 ( .A(Req_X_E), .B(n31), .C(n42), .Q(n34) );
  OAI211X1 U36 ( .A1(n39), .A2(n37), .B1(Req_X_E), .C1(n40), .Q(n32) );
  NAND2XL U37 ( .A(n34), .B(n32), .Q(X_E) );
  AOI21X1 U38 ( .A1(Req_X_E), .A2(n37), .B1(n39), .Q(n36) );
  NOR2XL U39 ( .A(state[1]), .B(n33), .Q(n35) );
  OAI31X1 U40 ( .A1(Req_X_N), .A2(n36), .A3(n35), .B1(n34), .Q(n47) );
endmodule


module arbiter_in_1 ( reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L, 
        X_N, X_E, X_W, X_S, X_L );
  input reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L;
  output X_N, X_E, X_W, X_S, X_L;
  wire   n44, n45, n46, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40;
  wire   [2:0] state;

  DFCX1 \state_reg[0]  ( .D(n46), .CP(clk), .RN(reset), .Q(state[0]), .QN(n39)
         );
  DFCX1 \state_reg[1]  ( .D(n45), .CP(clk), .RN(reset), .Q(state[1]), .QN(n38)
         );
  DFCX1 \state_reg[2]  ( .D(n44), .CP(clk), .RN(reset), .Q(state[2]), .QN(n40)
         );
  INVXL U3 ( .A(n31), .Q(X_L) );
  NOR2XL U4 ( .A(Req_X_N), .B(Req_X_L), .Q(n35) );
  INVXL U5 ( .A(Req_X_W), .Q(n34) );
  NOR2XL U6 ( .A(n30), .B(n34), .Q(X_W) );
  OR2X1 U7 ( .A(n25), .B(Req_X_N), .Q(n27) );
  AOI21X2 U8 ( .A1(n36), .A2(n32), .B1(n29), .Q(n30) );
  OAI21X1 U9 ( .A1(n28), .A2(n40), .B1(n27), .Q(n32) );
  NAND2XL U10 ( .A(state[1]), .B(n40), .Q(n20) );
  OAI21X1 U11 ( .A1(n22), .A2(n21), .B1(Req_X_L), .Q(n31) );
  AOI21X1 U12 ( .A1(Req_X_E), .A2(n39), .B1(n20), .Q(n29) );
  AOI221X1 U13 ( .A1(n26), .A2(n25), .B1(Req_X_L), .B2(n25), .C1(n24), .Q(X_N)
         );
  AOI21X1 U14 ( .A1(n29), .A2(n34), .B1(state[2]), .Q(n26) );
  AOI211X1 U15 ( .A1(n35), .A2(n34), .B1(n33), .C1(n32), .Q(n37) );
  NOR2XL U16 ( .A(n37), .B(n36), .Q(X_E) );
  INVXL U17 ( .A(Req_X_E), .Q(n36) );
  NAND2XL U18 ( .A(n34), .B(n36), .Q(n16) );
  NOR2XL U19 ( .A(Req_X_N), .B(n16), .Q(n21) );
  INVXL U20 ( .A(Req_X_L), .Q(n11) );
  NAND2XL U21 ( .A(n21), .B(n11), .Q(n23) );
  NAND2XL U22 ( .A(n40), .B(n38), .Q(n25) );
  INVXL U23 ( .A(Req_X_N), .Q(n24) );
  NOR2XL U24 ( .A(n39), .B(n20), .Q(n13) );
  INVXL U25 ( .A(n35), .Q(n28) );
  OAI21X1 U26 ( .A1(state[2]), .A2(n13), .B1(n28), .Q(n12) );
  OAI211X1 U27 ( .A1(n25), .A2(n24), .B1(Req_X_E), .C1(n12), .Q(n14) );
  AND2X1 U28 ( .A(Req_X_W), .B(n13), .Q(n18) );
  OAI21X1 U29 ( .A1(n14), .A2(n18), .B1(n23), .Q(n15) );
  OAI21X1 U30 ( .A1(n23), .A2(n39), .B1(n15), .Q(n46) );
  NOR2XL U31 ( .A(state[0]), .B(n20), .Q(n33) );
  NAND2XL U32 ( .A(n28), .B(n27), .Q(n17) );
  OAI31X1 U33 ( .A1(n18), .A2(n33), .A3(n17), .B1(n16), .Q(n19) );
  OAI21X1 U34 ( .A1(n23), .A2(n38), .B1(n19), .Q(n45) );
  INVXL U35 ( .A(n26), .Q(n22) );
  OAI21X1 U36 ( .A1(n23), .A2(n40), .B1(n31), .Q(n44) );
endmodule


module arbiter_in_0 ( reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L, 
        X_N, X_E, X_W, X_S, X_L );
  input reset, clk, Req_X_N, Req_X_E, Req_X_W, Req_X_S, Req_X_L;
  output X_N, X_E, X_W, X_S, X_L;
  wire   n37, n38, n39, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n40,
         n41, n42, n43, n44, n45, n46;
  wire   [2:0] state;

  DFCX1 \state_reg[2]  ( .D(n37), .CP(clk), .RN(reset), .Q(state[2]), .QN(n46)
         );
  DFCX1 \state_reg[1]  ( .D(n38), .CP(clk), .RN(reset), .Q(state[1]), .QN(n45)
         );
  DFCX1 \state_reg[0]  ( .D(n39), .CP(clk), .RN(reset), .Q(state[0]) );
  NOR2XL U3 ( .A(n41), .B(n40), .Q(n43) );
  NOR2X2 U4 ( .A(n34), .B(n33), .Q(X_E) );
  NOR3X2 U5 ( .A(n46), .B(state[0]), .C(state[1]), .Q(n41) );
  NOR2X2 U6 ( .A(n32), .B(n41), .Q(n25) );
  AOI22X1 U7 ( .A1(n32), .A2(n31), .B1(n30), .B2(n29), .Q(n34) );
  INVXL U8 ( .A(Req_X_E), .Q(n33) );
  NOR2XL U9 ( .A(n45), .B(state[2]), .Q(n32) );
  INVXL U10 ( .A(Req_X_N), .Q(n30) );
  NOR2XL U11 ( .A(n43), .B(n42), .Q(X_S) );
  INVXL U12 ( .A(n32), .Q(n14) );
  OAI21X1 U13 ( .A1(n41), .A2(Req_X_N), .B1(n14), .Q(n13) );
  NAND2XL U14 ( .A(Req_X_W), .B(n13), .Q(n17) );
  INVXL U15 ( .A(n25), .Q(n18) );
  OAI22X1 U16 ( .A1(state[0]), .A2(n14), .B1(Req_X_N), .B2(n18), .Q(n15) );
  INVXL U17 ( .A(Req_X_S), .Q(n42) );
  AOI22X1 U18 ( .A1(Req_X_E), .A2(n15), .B1(n42), .B2(n30), .Q(n16) );
  INVXL U19 ( .A(Req_X_W), .Q(n26) );
  NAND2XL U20 ( .A(n26), .B(n42), .Q(n27) );
  NAND2XL U21 ( .A(n33), .B(n30), .Q(n35) );
  NOR2XL U22 ( .A(n27), .B(n35), .Q(n44) );
  AOI22X1 U23 ( .A1(n17), .A2(n16), .B1(n45), .B2(n44), .Q(n38) );
  OAI21X3 U24 ( .A1(state[0]), .A2(n33), .B1(n32), .Q(n36) );
  OAI21X1 U25 ( .A1(Req_X_E), .A2(n18), .B1(n36), .Q(n22) );
  NOR2XL U26 ( .A(n30), .B(n18), .Q(n21) );
  OAI21X1 U27 ( .A1(state[0]), .A2(n41), .B1(Req_X_N), .Q(n19) );
  AOI21X1 U28 ( .A1(Req_X_E), .A2(n19), .B1(Req_X_S), .Q(n20) );
  AOI211X1 U29 ( .A1(Req_X_W), .A2(n22), .B1(n21), .C1(n20), .Q(n24) );
  NAND2XL U30 ( .A(n44), .B(state[0]), .Q(n23) );
  OAI21X1 U31 ( .A1(n24), .A2(n44), .B1(n23), .Q(n39) );
  AOI21X3 U32 ( .A1(n41), .A2(n42), .B1(n25), .Q(n28) );
  AOI221X3 U33 ( .A1(n27), .A2(n28), .B1(n36), .B2(n28), .C1(n30), .Q(X_N) );
  AOI221X3 U34 ( .A1(n28), .A2(n36), .B1(n35), .B2(n36), .C1(n26), .Q(X_W) );
  OAI21X1 U35 ( .A1(Req_X_N), .A2(n27), .B1(state[0]), .Q(n31) );
  INVXL U36 ( .A(n28), .Q(n29) );
  AOI21X3 U37 ( .A1(n36), .A2(n35), .B1(Req_X_W), .Q(n40) );
  AO21X1 U38 ( .A1(state[2]), .A2(n44), .B1(X_S), .Q(n37) );
endmodule


module arbiter_out_4 ( reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y, credit, 
        grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L );
  input [1:0] credit;
  input reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y;
  output grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L;
  wire   N52, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32;
  wire   [2:0] state;
  wire   [2:0] state_in;
  assign N52 = X_L_Y;

  DFCX1 \state_reg[0]  ( .D(state_in[0]), .CP(clk), .RN(reset), .Q(state[0])
         );
  DFCX1 \state_reg[2]  ( .D(state_in[2]), .CP(clk), .RN(reset), .Q(state[2]), 
        .QN(n32) );
  DFCX1 \state_reg[1]  ( .D(state_in[1]), .CP(clk), .RN(reset), .Q(state[1])
         );
  NOR3X1 U3 ( .A(n25), .B(n31), .C(n24), .Q(grant_Y_L) );
  INVX2 U4 ( .A(n26), .Q(n28) );
  NOR2X2 U5 ( .A(state[0]), .B(n21), .Q(n26) );
  NAND2XL U6 ( .A(state[2]), .B(N52), .Q(n24) );
  NOR3X2 U7 ( .A(n31), .B(n28), .C(n27), .Q(grant_Y_E) );
  NOR3X2 U8 ( .A(n31), .B(n30), .C(n29), .Q(grant_Y_W) );
  NOR3X1 U9 ( .A(n31), .B(n14), .C(n32), .Q(grant_Y_S) );
  INVXL U10 ( .A(X_W_Y), .Q(n29) );
  INVXL U11 ( .A(X_E_Y), .Q(n21) );
  OAI31X1 U12 ( .A1(n13), .A2(n26), .A3(n27), .B1(n12), .Q(state_in[0]) );
  INVXL U13 ( .A(X_S_Y), .Q(n9) );
  AOI21X1 U14 ( .A1(N52), .A2(n9), .B1(X_W_Y), .Q(n13) );
  NAND2XL U15 ( .A(state[1]), .B(n32), .Q(n27) );
  NOR2XL U16 ( .A(state[0]), .B(state[1]), .Q(n25) );
  NAND2XL U17 ( .A(X_S_Y), .B(n25), .Q(n14) );
  NAND2XL U18 ( .A(n14), .B(state[2]), .Q(n20) );
  INVXL U19 ( .A(n20), .Q(n11) );
  OAI22X1 U20 ( .A1(state[2]), .A2(n13), .B1(n20), .B2(n29), .Q(n10) );
  AOI22X1 U21 ( .A1(n11), .A2(N52), .B1(n21), .B2(n10), .Q(n12) );
  NOR2XL U22 ( .A(credit[0]), .B(credit[1]), .Q(n31) );
  NOR2XL U23 ( .A(N52), .B(X_S_Y), .Q(n19) );
  INVXL U24 ( .A(n27), .Q(n15) );
  NAND2XL U25 ( .A(state[0]), .B(n15), .Q(n30) );
  AOI21X1 U26 ( .A1(n30), .A2(X_E_Y), .B1(X_W_Y), .Q(n16) );
  AOI21X1 U27 ( .A1(n25), .A2(state[2]), .B1(n16), .Q(n17) );
  OAI21X1 U28 ( .A1(n19), .A2(n17), .B1(n24), .Q(state_in[2]) );
  AOI21X1 U29 ( .A1(state[0]), .A2(state[1]), .B1(state[2]), .Q(n18) );
  OAI21X1 U30 ( .A1(n19), .A2(n18), .B1(X_E_Y), .Q(n23) );
  AO211X1 U31 ( .A1(n21), .A2(n29), .B1(n20), .C1(N52), .Q(n22) );
  OAI211X1 U32 ( .A1(state[2]), .A2(n29), .B1(n23), .C1(n22), .Q(state_in[1])
         );
endmodule


module arbiter_out_3 ( reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y, credit, 
        grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L );
  input [1:0] credit;
  input reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y;
  output grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L;
  wire   n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n25, n26, n27;
  wire   [2:0] state;
  wire   [2:0] state_in;

  DFCX1 \state_reg[0]  ( .D(state_in[0]), .CP(clk), .RN(reset), .Q(state[0])
         );
  DFCX1 \state_reg[2]  ( .D(state_in[2]), .CP(clk), .RN(reset), .Q(state[2]), 
        .QN(n26) );
  DFCX1 \state_reg[1]  ( .D(state_in[1]), .CP(clk), .RN(reset), .Q(state[1]), 
        .QN(n27) );
  INVX2 U3 ( .A(X_L_Y), .Q(n22) );
  OR2X1 U4 ( .A(credit[0]), .B(credit[1]), .Q(n9) );
  NOR3X1 U5 ( .A(n27), .B(n25), .C(n24), .Q(grant_Y_W) );
  NOR2XL U6 ( .A(n10), .B(n24), .Q(grant_Y_N) );
  NOR3X1 U7 ( .A(n23), .B(n22), .C(n21), .Q(grant_Y_L) );
  NOR2XL U8 ( .A(n16), .B(n21), .Q(grant_Y_S) );
  NOR2XL U9 ( .A(state[0]), .B(state[1]), .Q(n23) );
  NAND2XL U10 ( .A(X_S_Y), .B(n23), .Q(n16) );
  NAND2XL U11 ( .A(state[2]), .B(n9), .Q(n21) );
  NAND2XL U12 ( .A(n27), .B(X_N_Y), .Q(n10) );
  OAI211X1 U13 ( .A1(credit[0]), .A2(credit[1]), .B1(state[0]), .C1(n26), .Q(
        n24) );
  NOR2XL U14 ( .A(X_L_Y), .B(X_N_Y), .Q(n13) );
  NAND2XL U15 ( .A(n13), .B(n16), .Q(n11) );
  INVXL U16 ( .A(n10), .Q(n12) );
  INVXL U17 ( .A(X_W_Y), .Q(n25) );
  AOI211X1 U18 ( .A1(state[2]), .A2(n11), .B1(n12), .C1(n25), .Q(state_in[1])
         );
  NOR2XL U19 ( .A(X_W_Y), .B(X_N_Y), .Q(n17) );
  NAND2XL U20 ( .A(n17), .B(n22), .Q(n15) );
  NOR2XL U21 ( .A(X_W_Y), .B(n12), .Q(n18) );
  OAI21X1 U22 ( .A1(X_S_Y), .A2(n13), .B1(n18), .Q(n14) );
  AO32X1 U23 ( .A1(state[2]), .A2(n16), .A3(n15), .B1(n26), .B2(n14), .Q(
        state_in[0]) );
  OAI21X1 U24 ( .A1(n23), .A2(n17), .B1(X_S_Y), .Q(n20) );
  OAI21X1 U25 ( .A1(X_L_Y), .A2(X_S_Y), .B1(n18), .Q(n19) );
  AOI32X1 U26 ( .A1(n22), .A2(state[2]), .A3(n20), .B1(n19), .B2(n26), .Q(
        state_in[2]) );
endmodule


module arbiter_out_2 ( reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y, credit, 
        grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L );
  input [1:0] credit;
  input reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y;
  output grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L;
  wire   n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34;
  wire   [2:0] state;
  wire   [2:0] state_in;

  DFCX1 \state_reg[0]  ( .D(state_in[0]), .CP(clk), .RN(reset), .Q(state[0]), 
        .QN(n33) );
  DFCX1 \state_reg[2]  ( .D(state_in[2]), .CP(clk), .RN(reset), .Q(state[2])
         );
  DFCX1 \state_reg[1]  ( .D(state_in[1]), .CP(clk), .RN(reset), .Q(state[1]), 
        .QN(n34) );
  AOI31X2 U3 ( .A1(X_L_Y), .A2(n20), .A3(n10), .B1(X_N_Y), .Q(n17) );
  INVXL U4 ( .A(X_S_Y), .Q(n20) );
  NOR4X2 U5 ( .A(state[2]), .B(n23), .C(n10), .D(n9), .Q(grant_Y_E) );
  INVX2 U6 ( .A(X_E_Y), .Q(n10) );
  INVXL U7 ( .A(X_N_Y), .Q(n22) );
  NOR3X1 U8 ( .A(n23), .B(n19), .C(n18), .Q(grant_Y_L) );
  NOR3X1 U9 ( .A(n23), .B(n25), .C(n20), .Q(grant_Y_S) );
  AOI221X1 U10 ( .A1(n8), .A2(n27), .B1(n13), .B2(n27), .C1(n10), .Q(
        state_in[1]) );
  OAI31X1 U11 ( .A1(n28), .A2(n15), .A3(n14), .B1(n13), .Q(n16) );
  NAND2XL U12 ( .A(n33), .B(n34), .Q(n11) );
  NAND2XL U13 ( .A(n11), .B(state[2]), .Q(n19) );
  INVXL U14 ( .A(n19), .Q(n28) );
  NOR2XL U15 ( .A(n28), .B(n20), .Q(n8) );
  AO221X1 U16 ( .A1(state[1]), .A2(state[0]), .B1(n34), .B2(X_N_Y), .C1(
        state[2]), .Q(n27) );
  INVXL U17 ( .A(X_L_Y), .Q(n18) );
  NAND2XL U18 ( .A(n22), .B(n18), .Q(n13) );
  NOR2XL U19 ( .A(credit[0]), .B(credit[1]), .Q(n23) );
  NAND2XL U20 ( .A(state[1]), .B(n33), .Q(n9) );
  INVXL U21 ( .A(n11), .Q(n12) );
  NAND2XL U22 ( .A(n12), .B(state[2]), .Q(n25) );
  NOR2XL U23 ( .A(X_S_Y), .B(n25), .Q(n15) );
  AOI211X1 U24 ( .A1(X_E_Y), .A2(n33), .B1(X_S_Y), .C1(n34), .Q(n14) );
  OAI31X1 U25 ( .A1(state[1]), .A2(state[2]), .A3(n17), .B1(n16), .Q(
        state_in[0]) );
  NOR2XL U26 ( .A(state[2]), .B(n33), .Q(n24) );
  INVXL U27 ( .A(n24), .Q(n21) );
  NOR4X3 U28 ( .A(state[1]), .B(n23), .C(n22), .D(n21), .Q(grant_Y_N) );
  NAND2XL U29 ( .A(state[1]), .B(n24), .Q(n26) );
  OAI211X1 U30 ( .A1(X_E_Y), .A2(n27), .B1(n26), .C1(n25), .Q(n30) );
  OAI21X1 U31 ( .A1(n30), .A2(n28), .B1(X_L_Y), .Q(n32) );
  NOR2XL U32 ( .A(X_E_Y), .B(X_N_Y), .Q(n29) );
  OAI21X1 U33 ( .A1(n30), .A2(n29), .B1(X_S_Y), .Q(n31) );
  NAND2XL U34 ( .A(n32), .B(n31), .Q(state_in[2]) );
endmodule


module arbiter_out_1 ( reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y, credit, 
        grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L );
  input [1:0] credit;
  input reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y;
  output grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L;
  wire   N63, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30;
  wire   [2:0] state;
  wire   [2:0] state_in;
  assign N63 = X_L_Y;

  DFCX1 \state_reg[0]  ( .D(state_in[0]), .CP(clk), .RN(reset), .Q(state[0]), 
        .QN(n30) );
  DFCX1 \state_reg[2]  ( .D(state_in[2]), .CP(clk), .RN(reset), .Q(state[2])
         );
  DFCX1 \state_reg[1]  ( .D(state_in[1]), .CP(clk), .RN(reset), .Q(state[1]), 
        .QN(n29) );
  INVXL U3 ( .A(X_W_Y), .Q(n20) );
  OR2X1 U4 ( .A(n16), .B(n9), .Q(n10) );
  NOR3X3 U5 ( .A(n20), .B(n30), .C(n10), .Q(grant_Y_W) );
  OAI211X1 U6 ( .A1(state[1]), .A2(n28), .B1(n27), .C1(n26), .Q(state_in[0])
         );
  NOR2XL U7 ( .A(state[2]), .B(n29), .Q(n24) );
  INVXL U8 ( .A(n24), .Q(n16) );
  NOR2XL U9 ( .A(credit[0]), .B(credit[1]), .Q(n9) );
  NAND2XL U10 ( .A(N63), .B(state[2]), .Q(n15) );
  AOI211X3 U11 ( .A1(n29), .A2(n30), .B1(n9), .C1(n15), .Q(grant_Y_L) );
  NAND2XL U12 ( .A(X_E_Y), .B(n30), .Q(n23) );
  NOR2XL U13 ( .A(n23), .B(n10), .Q(grant_Y_E) );
  NOR2XL U14 ( .A(X_E_Y), .B(X_N_Y), .Q(n11) );
  INVXL U15 ( .A(X_E_Y), .Q(n21) );
  OAI22X1 U16 ( .A1(n24), .A2(n11), .B1(state[0]), .B2(n21), .Q(n12) );
  INVXL U17 ( .A(N63), .Q(n14) );
  OAI31X1 U18 ( .A1(X_W_Y), .A2(n12), .A3(n14), .B1(n15), .Q(state_in[2]) );
  OAI211X1 U19 ( .A1(credit[0]), .A2(credit[1]), .B1(X_N_Y), .C1(n29), .Q(n13)
         );
  NOR3X1 U20 ( .A(state[2]), .B(n30), .C(n13), .Q(grant_Y_N) );
  INVXL U21 ( .A(X_N_Y), .Q(n19) );
  NAND2XL U22 ( .A(n14), .B(n19), .Q(n25) );
  AO21X1 U23 ( .A1(state[0]), .A2(n25), .B1(n21), .Q(n18) );
  OAI211X1 U24 ( .A1(X_E_Y), .A2(X_W_Y), .B1(n15), .C1(n19), .Q(n17) );
  AOI32X1 U25 ( .A1(n20), .A2(n24), .A3(n18), .B1(n17), .B2(n16), .Q(
        state_in[1]) );
  OAI21X1 U26 ( .A1(X_E_Y), .A2(n20), .B1(n19), .Q(n22) );
  AOI21X1 U27 ( .A1(N63), .A2(n21), .B1(n22), .Q(n28) );
  OAI21X1 U28 ( .A1(N63), .A2(n22), .B1(state[2]), .Q(n27) );
  OAI211X1 U29 ( .A1(X_W_Y), .A2(n25), .B1(n24), .C1(n23), .Q(n26) );
endmodule


module arbiter_out_0 ( reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y, credit, 
        grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L );
  input [1:0] credit;
  input reset, clk, X_N_Y, X_E_Y, X_W_Y, X_S_Y, X_L_Y;
  output grant_Y_N, grant_Y_E, grant_Y_W, grant_Y_S, grant_Y_L;
  wire   N38, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30;
  wire   [2:0] state;
  wire   [2:0] state_in;
  assign N38 = X_W_Y;

  DFCX1 \state_reg[0]  ( .D(state_in[0]), .CP(clk), .RN(reset), .Q(state[0]), 
        .QN(n30) );
  DFCX1 \state_reg[2]  ( .D(state_in[2]), .CP(clk), .RN(reset), .Q(state[2]), 
        .QN(n29) );
  DFCX1 \state_reg[1]  ( .D(state_in[1]), .CP(clk), .RN(reset), .Q(state[1])
         );
  NOR2XL U3 ( .A(state[0]), .B(n20), .Q(n14) );
  NAND3X2 U4 ( .A(state[2]), .B(X_S_Y), .C(n10), .Q(n25) );
  OR2X1 U5 ( .A(n17), .B(n26), .Q(n27) );
  NOR3X2 U6 ( .A(n28), .B(n30), .C(n27), .Q(grant_Y_W) );
  INVXL U7 ( .A(N38), .Q(n28) );
  NOR2XL U8 ( .A(n8), .B(n27), .Q(grant_Y_E) );
  INVXL U9 ( .A(X_E_Y), .Q(n20) );
  NOR2XL U10 ( .A(n26), .B(n25), .Q(grant_Y_S) );
  NOR3X1 U11 ( .A(state[1]), .B(n30), .C(n9), .Q(grant_Y_N) );
  OAI211X1 U12 ( .A1(credit[0]), .A2(credit[1]), .B1(X_N_Y), .C1(n29), .Q(n9)
         );
  OAI21X1 U13 ( .A1(n21), .A2(n17), .B1(n16), .Q(state_in[1]) );
  OAI31X1 U14 ( .A1(n24), .A2(n23), .A3(n22), .B1(n25), .Q(state_in[2]) );
  OAI31X1 U15 ( .A1(n14), .A2(n13), .A3(n17), .B1(n12), .Q(state_in[0]) );
  AOI21X1 U16 ( .A1(n20), .A2(n19), .B1(n18), .Q(n24) );
  INVXL U17 ( .A(n14), .Q(n8) );
  NAND2XL U18 ( .A(state[1]), .B(n29), .Q(n17) );
  NOR2XL U19 ( .A(credit[0]), .B(credit[1]), .Q(n26) );
  INVXL U20 ( .A(X_S_Y), .Q(n23) );
  AOI21X1 U21 ( .A1(X_N_Y), .A2(n23), .B1(N38), .Q(n13) );
  NOR2XL U22 ( .A(state[1]), .B(state[0]), .Q(n10) );
  INVXL U23 ( .A(n17), .Q(n18) );
  INVXL U24 ( .A(X_N_Y), .Q(n19) );
  OAI22X1 U25 ( .A1(n18), .A2(n19), .B1(X_E_Y), .B2(n28), .Q(n11) );
  NAND2XL U26 ( .A(n25), .B(n11), .Q(n12) );
  NOR2XL U27 ( .A(N38), .B(n14), .Q(n21) );
  AOI21X1 U28 ( .A1(n18), .A2(X_S_Y), .B1(n20), .Q(n15) );
  OAI211X1 U29 ( .A1(N38), .A2(n15), .B1(n19), .C1(n25), .Q(n16) );
  INVXL U30 ( .A(n21), .Q(n22) );
endmodule


module allocator ( reset, clk, credit_in_N, credit_in_E, credit_in_W, 
        credit_in_S, credit_in_L, req_N_N, req_N_E, req_N_W, req_N_S, req_N_L, 
        req_E_N, req_E_E, req_E_W, req_E_L, req_W_N, req_W_E, req_W_W, req_W_L, 
        req_S_N, req_S_E, req_S_W, req_S_S, req_S_L, req_L_N, req_L_E, req_L_W, 
        req_L_S, req_L_L, empty_N, empty_E, empty_W, empty_S, empty_L, valid_N, 
        valid_E, valid_W, valid_S, valid_L, grant_N_N, grant_N_E, grant_N_W, 
        grant_N_S, grant_N_L, grant_E_N, grant_E_E, grant_E_W, grant_E_S, 
        grant_E_L, grant_W_N, grant_W_E, grant_W_W, grant_W_S, grant_W_L, 
        grant_S_N, grant_S_E, grant_S_W, grant_S_S, grant_S_L, grant_L_N, 
        grant_L_E, grant_L_W, grant_L_S, grant_L_L, req_W_S_BAR, req_E_S_BAR
 );
  input reset, clk, credit_in_N, credit_in_E, credit_in_W, credit_in_S,
         credit_in_L, req_N_N, req_N_E, req_N_W, req_N_S, req_N_L, req_E_N,
         req_E_E, req_E_W, req_E_L, req_W_N, req_W_E, req_W_W, req_W_L,
         req_S_N, req_S_E, req_S_W, req_S_S, req_S_L, req_L_N, req_L_E,
         req_L_W, req_L_S, req_L_L, empty_N, empty_E, empty_W, empty_S,
         empty_L, req_W_S_BAR, req_E_S_BAR;
  output valid_N, valid_E, valid_W, valid_S, valid_L, grant_N_N, grant_N_E,
         grant_N_W, grant_N_S, grant_N_L, grant_E_N, grant_E_E, grant_E_W,
         grant_E_S, grant_E_L, grant_W_N, grant_W_E, grant_W_W, grant_W_S,
         grant_W_L, grant_S_N, grant_S_E, grant_S_W, grant_S_S, grant_S_L,
         grant_L_N, grant_L_E, grant_L_W, grant_L_S, grant_L_L;
  wire   n1, req_E_S, req_W_S, grant_N_E_sig, grant_N_W_sig, grant_N_S_sig,
         grant_N_L_sig, grant_E_N_sig, grant_E_W_sig, grant_E_S_sig,
         grant_E_L_sig, grant_W_N_sig, grant_W_E_sig, grant_W_S_sig,
         grant_W_L_sig, grant_S_N_sig, grant_S_E_sig, grant_S_W_sig,
         grant_S_L_sig, grant_L_N_sig, grant_L_E_sig, grant_L_W_sig,
         grant_L_S_sig, X_N_E, X_N_W, X_N_S, X_N_L, X_E_N, X_E_W, X_E_S, X_E_L,
         X_W_N, X_W_E, X_W_S, X_W_L, X_S_N, X_S_E, X_S_W, X_S_L, X_L_N, X_L_E,
         X_L_W, X_L_S, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69;
  wire   [1:0] credit_counter_N_out;
  wire   [1:0] credit_counter_E_out;
  wire   [1:0] credit_counter_W_out;
  wire   [1:0] credit_counter_S_out;
  wire   [1:0] credit_counter_L_out;
  wire   [1:0] credit_counter_N_in;
  wire   [1:0] credit_counter_E_in;
  wire   [1:0] credit_counter_W_in;
  wire   [1:0] credit_counter_S_in;
  wire   [1:0] credit_counter_L_in;
  assign req_E_S = req_E_S_BAR;
  assign req_W_S = req_W_S_BAR;

  arbiter_in_4 arb_N_X ( .reset(reset), .clk(clk), .Req_X_N(n1), .Req_X_E(
        req_N_E), .Req_X_W(req_N_W), .Req_X_S(req_N_S), .Req_X_L(req_N_L), 
        .X_E(X_N_E), .X_W(X_N_W), .X_S(X_N_S), .X_L(X_N_L) );
  arbiter_in_3 arb_E_X ( .reset(reset), .clk(clk), .Req_X_N(req_E_N), 
        .Req_X_E(n1), .Req_X_W(req_E_W), .Req_X_L(req_E_L), .X_N(X_E_N), .X_W(
        X_E_W), .X_S(X_E_S), .X_L(X_E_L), .Req_X_S_BAR(req_E_S) );
  arbiter_in_2 arb_W_X ( .reset(reset), .clk(clk), .Req_X_N(req_W_N), 
        .Req_X_E(req_W_E), .Req_X_W(n1), .Req_X_L(req_W_L), .X_N(X_W_N), .X_E(
        X_W_E), .X_S(X_W_S), .X_L(X_W_L), .Req_X_S_BAR(req_W_S) );
  arbiter_in_1 arb_S_X ( .reset(reset), .clk(clk), .Req_X_N(req_S_N), 
        .Req_X_E(req_S_E), .Req_X_W(req_S_W), .Req_X_S(n1), .Req_X_L(req_S_L), 
        .X_N(X_S_N), .X_E(X_S_E), .X_W(X_S_W), .X_L(X_S_L) );
  arbiter_in_0 arb_L_X ( .reset(reset), .clk(clk), .Req_X_N(req_L_N), 
        .Req_X_E(req_L_E), .Req_X_W(req_L_W), .Req_X_S(req_L_S), .Req_X_L(n1), 
        .X_N(X_L_N), .X_E(X_L_E), .X_W(X_L_W), .X_S(X_L_S) );
  arbiter_out_4 arb_X_N ( .reset(reset), .clk(clk), .X_N_Y(n1), .X_E_Y(X_E_N), 
        .X_W_Y(X_W_N), .X_S_Y(X_S_N), .X_L_Y(X_L_N), .credit(
        credit_counter_N_out), .grant_Y_E(grant_N_E_sig), .grant_Y_W(
        grant_N_W_sig), .grant_Y_S(grant_N_S_sig), .grant_Y_L(grant_N_L_sig)
         );
  arbiter_out_3 arb_X_E ( .reset(reset), .clk(clk), .X_N_Y(X_N_E), .X_E_Y(n1), 
        .X_W_Y(X_W_E), .X_S_Y(X_S_E), .X_L_Y(X_L_E), .credit(
        credit_counter_E_out), .grant_Y_N(grant_E_N_sig), .grant_Y_W(
        grant_E_W_sig), .grant_Y_S(grant_E_S_sig), .grant_Y_L(grant_E_L_sig)
         );
  arbiter_out_2 arb_X_W ( .reset(reset), .clk(clk), .X_N_Y(X_N_W), .X_E_Y(
        X_E_W), .X_W_Y(n1), .X_S_Y(X_S_W), .X_L_Y(X_L_W), .credit(
        credit_counter_W_out), .grant_Y_N(grant_W_N_sig), .grant_Y_E(
        grant_W_E_sig), .grant_Y_S(grant_W_S_sig), .grant_Y_L(grant_W_L_sig)
         );
  arbiter_out_1 arb_X_S ( .reset(reset), .clk(clk), .X_N_Y(X_N_S), .X_E_Y(
        X_E_S), .X_W_Y(X_W_S), .X_S_Y(n1), .X_L_Y(X_L_S), .credit(
        credit_counter_S_out), .grant_Y_N(grant_S_N_sig), .grant_Y_E(
        grant_S_E_sig), .grant_Y_W(grant_S_W_sig), .grant_Y_L(grant_S_L_sig)
         );
  arbiter_out_0 arb_X_L ( .reset(reset), .clk(clk), .X_N_Y(X_N_L), .X_E_Y(
        X_E_L), .X_W_Y(X_W_L), .X_S_Y(X_S_L), .X_L_Y(n1), .credit(
        credit_counter_L_out), .grant_Y_N(grant_L_N_sig), .grant_Y_E(
        grant_L_E_sig), .grant_Y_W(grant_L_W_sig), .grant_Y_S(grant_L_S_sig)
         );
  DFPX1 \credit_counter_L_out_reg[0]  ( .D(credit_counter_L_in[0]), .CP(clk), 
        .SN(reset), .Q(credit_counter_L_out[0]), .QN(n65) );
  DFPX1 \credit_counter_L_out_reg[1]  ( .D(credit_counter_L_in[1]), .CP(clk), 
        .SN(reset), .Q(credit_counter_L_out[1]) );
  DFPX1 \credit_counter_N_out_reg[0]  ( .D(credit_counter_N_in[0]), .CP(clk), 
        .SN(reset), .Q(credit_counter_N_out[0]), .QN(n69) );
  DFPX1 \credit_counter_N_out_reg[1]  ( .D(credit_counter_N_in[1]), .CP(clk), 
        .SN(reset), .Q(credit_counter_N_out[1]) );
  DFPX1 \credit_counter_E_out_reg[0]  ( .D(credit_counter_E_in[0]), .CP(clk), 
        .SN(reset), .Q(credit_counter_E_out[0]), .QN(n68) );
  DFPX1 \credit_counter_E_out_reg[1]  ( .D(credit_counter_E_in[1]), .CP(clk), 
        .SN(reset), .Q(credit_counter_E_out[1]) );
  DFPX1 \credit_counter_W_out_reg[0]  ( .D(credit_counter_W_in[0]), .CP(clk), 
        .SN(reset), .Q(credit_counter_W_out[0]), .QN(n67) );
  DFPX1 \credit_counter_W_out_reg[1]  ( .D(credit_counter_W_in[1]), .CP(clk), 
        .SN(reset), .Q(credit_counter_W_out[1]) );
  DFPX1 \credit_counter_S_out_reg[0]  ( .D(credit_counter_S_in[0]), .CP(clk), 
        .SN(reset), .Q(credit_counter_S_out[0]), .QN(n66) );
  DFPX1 \credit_counter_S_out_reg[1]  ( .D(credit_counter_S_in[1]), .CP(clk), 
        .SN(reset), .Q(credit_counter_S_out[1]) );
  AOI31X2 U3 ( .A1(valid_S), .A2(credit_counter_S_out[1]), .A3(n66), .B1(n55), 
        .Q(n58) );
  AOI31X2 U4 ( .A1(valid_N), .A2(credit_counter_N_out[1]), .A3(n69), .B1(n30), 
        .Q(n33) );
  INVXL U5 ( .A(empty_E), .Q(n27) );
  INVXL U6 ( .A(empty_W), .Q(n24) );
  INVXL U7 ( .A(grant_N_L_sig), .Q(n12) );
  INVXL U8 ( .A(n21), .Q(grant_W_E) );
  NOR2X3 U9 ( .A(empty_S), .B(n8), .Q(grant_W_S) );
  NOR2X3 U10 ( .A(empty_L), .B(n26), .Q(grant_S_L) );
  AOI31X2 U11 ( .A1(valid_L), .A2(credit_counter_L_out[1]), .A3(n65), .B1(n41), 
        .Q(n44) );
  AOI31X2 U12 ( .A1(valid_E), .A2(credit_counter_E_out[1]), .A3(n68), .B1(n34), 
        .Q(n37) );
  AOI31X2 U13 ( .A1(valid_W), .A2(credit_counter_W_out[1]), .A3(n67), .B1(n51), 
        .Q(n54) );
  NOR2X2 U14 ( .A(empty_S), .B(n7), .Q(grant_L_S) );
  AND2X2 U15 ( .A(n27), .B(grant_N_E_sig), .Q(grant_N_E) );
  INVX2 U16 ( .A(n29), .Q(grant_S_E) );
  INVX2 U17 ( .A(grant_S_L_sig), .Q(n26) );
  NOR3X1 U18 ( .A(grant_S_W), .B(grant_S_N), .C(grant_S_L), .Q(n28) );
  OAI31X1 U19 ( .A1(valid_S), .A2(n66), .A3(n64), .B1(n63), .Q(
        credit_counter_S_in[1]) );
  OAI31X1 U20 ( .A1(valid_W), .A2(n67), .A3(n61), .B1(n60), .Q(
        credit_counter_W_in[1]) );
  OAI31X1 U21 ( .A1(valid_E), .A2(n68), .A3(n47), .B1(n46), .Q(
        credit_counter_E_in[1]) );
  OAI31X1 U22 ( .A1(valid_N), .A2(n69), .A3(n40), .B1(n39), .Q(
        credit_counter_N_in[1]) );
  OAI21X1 U23 ( .A1(credit_in_S), .A2(n58), .B1(n57), .Q(
        credit_counter_S_in[0]) );
  OAI21X1 U24 ( .A1(credit_in_W), .A2(n54), .B1(n53), .Q(
        credit_counter_W_in[0]) );
  OAI21X1 U25 ( .A1(credit_in_E), .A2(n37), .B1(n36), .Q(
        credit_counter_E_in[0]) );
  OAI21X1 U26 ( .A1(credit_in_N), .A2(n33), .B1(n32), .Q(
        credit_counter_N_in[0]) );
  OAI21X1 U27 ( .A1(credit_in_L), .A2(n44), .B1(n43), .Q(
        credit_counter_L_in[0]) );
  INVXL U28 ( .A(grant_L_S_sig), .Q(n7) );
  INVXL U29 ( .A(grant_E_L_sig), .Q(n16) );
  NAND2XL U30 ( .A(n24), .B(grant_N_W_sig), .Q(n20) );
  OAI31X1 U31 ( .A1(valid_L), .A2(n65), .A3(n50), .B1(n49), .Q(
        credit_counter_L_in[1]) );
  LOGIC0 U32 ( .Q(n1) );
  AND2X3 U33 ( .A(n24), .B(grant_L_W_sig), .Q(grant_L_W) );
  INVXL U34 ( .A(grant_L_N_sig), .Q(n6) );
  NOR2X3 U35 ( .A(empty_N), .B(n6), .Q(grant_L_N) );
  INVXL U36 ( .A(grant_W_S_sig), .Q(n8) );
  INVXL U37 ( .A(grant_W_N_sig), .Q(n9) );
  NOR2X3 U38 ( .A(empty_N), .B(n9), .Q(grant_W_N) );
  INVXL U39 ( .A(grant_W_L_sig), .Q(n10) );
  NOR2X3 U40 ( .A(empty_L), .B(n10), .Q(grant_W_L) );
  INVXL U41 ( .A(grant_N_S_sig), .Q(n11) );
  NOR2X3 U42 ( .A(empty_S), .B(n11), .Q(grant_N_S) );
  NOR2X3 U43 ( .A(empty_L), .B(n12), .Q(grant_N_L) );
  NOR3X1 U44 ( .A(grant_N_S), .B(grant_N_E), .C(grant_N_L), .Q(n13) );
  NAND2XL U45 ( .A(n20), .B(n13), .Q(valid_N) );
  INVXL U46 ( .A(grant_E_S_sig), .Q(n14) );
  NOR2X3 U47 ( .A(empty_S), .B(n14), .Q(grant_E_S) );
  INVXL U48 ( .A(grant_E_N_sig), .Q(n15) );
  NOR2X3 U49 ( .A(empty_N), .B(n15), .Q(grant_E_N) );
  NOR2X3 U50 ( .A(empty_L), .B(n16), .Q(grant_E_L) );
  NAND2XL U51 ( .A(n24), .B(grant_E_W_sig), .Q(n23) );
  NOR3X1 U52 ( .A(grant_E_S), .B(grant_E_N), .C(grant_E_L), .Q(n17) );
  NAND2XL U53 ( .A(n23), .B(n17), .Q(valid_E) );
  NAND2XL U54 ( .A(n27), .B(grant_L_E_sig), .Q(n22) );
  NOR3X1 U55 ( .A(grant_L_W), .B(grant_L_N), .C(grant_L_S), .Q(n18) );
  NAND2XL U56 ( .A(n22), .B(n18), .Q(valid_L) );
  NAND2XL U57 ( .A(n27), .B(grant_W_E_sig), .Q(n21) );
  NOR3X1 U58 ( .A(grant_W_S), .B(grant_W_N), .C(grant_W_L), .Q(n19) );
  NAND2XL U59 ( .A(n21), .B(n19), .Q(valid_W) );
  CLKINVX2 U60 ( .A(n20), .Q(grant_N_W) );
  CLKINVX2 U61 ( .A(n22), .Q(grant_L_E) );
  CLKINVX2 U62 ( .A(n23), .Q(grant_E_W) );
  AND2X3 U63 ( .A(n24), .B(grant_S_W_sig), .Q(grant_S_W) );
  INVXL U64 ( .A(grant_S_N_sig), .Q(n25) );
  NOR2X3 U65 ( .A(empty_N), .B(n25), .Q(grant_S_N) );
  NAND2XL U66 ( .A(n27), .B(grant_S_E_sig), .Q(n29) );
  NAND2XL U67 ( .A(n29), .B(n28), .Q(valid_S) );
  NOR2XL U68 ( .A(valid_N), .B(n69), .Q(n30) );
  NAND2XL U69 ( .A(valid_N), .B(n69), .Q(n31) );
  OAI311X1 U70 ( .A1(credit_counter_N_out[1]), .A2(n69), .A3(valid_N), .B1(
        credit_in_N), .C1(n31), .Q(n32) );
  NOR2XL U71 ( .A(valid_E), .B(n68), .Q(n34) );
  NAND2XL U72 ( .A(valid_E), .B(n68), .Q(n35) );
  OAI311X1 U73 ( .A1(credit_counter_E_out[1]), .A2(n68), .A3(valid_E), .B1(
        credit_in_E), .C1(n35), .Q(n36) );
  INVXL U74 ( .A(credit_in_N), .Q(n40) );
  INVXL U75 ( .A(valid_N), .Q(n38) );
  OAI31X1 U76 ( .A1(credit_counter_N_out[0]), .A2(n38), .A3(credit_in_N), .B1(
        credit_counter_N_out[1]), .Q(n39) );
  NOR2XL U77 ( .A(valid_L), .B(n65), .Q(n41) );
  NAND2XL U78 ( .A(valid_L), .B(n65), .Q(n42) );
  OAI311X1 U79 ( .A1(credit_counter_L_out[1]), .A2(n65), .A3(valid_L), .B1(
        credit_in_L), .C1(n42), .Q(n43) );
  INVXL U80 ( .A(credit_in_E), .Q(n47) );
  INVXL U81 ( .A(valid_E), .Q(n45) );
  OAI31X1 U82 ( .A1(credit_counter_E_out[0]), .A2(n45), .A3(credit_in_E), .B1(
        credit_counter_E_out[1]), .Q(n46) );
  INVXL U83 ( .A(credit_in_L), .Q(n50) );
  INVXL U84 ( .A(valid_L), .Q(n48) );
  OAI31X1 U85 ( .A1(credit_counter_L_out[0]), .A2(n48), .A3(credit_in_L), .B1(
        credit_counter_L_out[1]), .Q(n49) );
  NOR2XL U86 ( .A(valid_W), .B(n67), .Q(n51) );
  NAND2XL U87 ( .A(valid_W), .B(n67), .Q(n52) );
  OAI311X1 U88 ( .A1(credit_counter_W_out[1]), .A2(n67), .A3(valid_W), .B1(
        credit_in_W), .C1(n52), .Q(n53) );
  NOR2XL U89 ( .A(valid_S), .B(n66), .Q(n55) );
  NAND2XL U90 ( .A(valid_S), .B(n66), .Q(n56) );
  OAI311X1 U91 ( .A1(credit_counter_S_out[1]), .A2(n66), .A3(valid_S), .B1(
        credit_in_S), .C1(n56), .Q(n57) );
  INVXL U92 ( .A(credit_in_W), .Q(n61) );
  INVXL U93 ( .A(valid_W), .Q(n59) );
  OAI31X1 U94 ( .A1(credit_counter_W_out[0]), .A2(n59), .A3(credit_in_W), .B1(
        credit_counter_W_out[1]), .Q(n60) );
  INVXL U95 ( .A(credit_in_S), .Q(n64) );
  INVXL U96 ( .A(valid_S), .Q(n62) );
  OAI31X1 U97 ( .A1(credit_counter_S_out[0]), .A2(n62), .A3(credit_in_S), .B1(
        credit_counter_S_out[1]), .Q(n63) );
endmodule


module XBAR_DATA_WIDTH32_4 ( North_in, East_in, West_in, South_in, Local_in, 
        sel, Data_out );
  input [31:0] North_in;
  input [31:0] East_in;
  input [31:0] West_in;
  input [31:0] South_in;
  input [31:0] Local_in;
  input [4:0] sel;
  output [31:0] Data_out;
  wire   n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73,
         n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111;

  BUFX12 U1 ( .A(n52), .Q(n3) );
  NOR2XL U2 ( .A(sel[2]), .B(sel[3]), .Q(n5) );
  NOR4X3 U3 ( .A(n17), .B(n105), .C(n10), .D(n95), .Q(n52) );
  NOR2X4 U4 ( .A(sel[2]), .B(n7), .Q(n10) );
  INVX4 U5 ( .A(n51), .Q(n17) );
  NAND3X2 U6 ( .A(sel[1]), .B(n5), .C(n4), .Q(n51) );
  NOR2X2 U7 ( .A(sel[0]), .B(sel[1]), .Q(n8) );
  AOI22X1 U8 ( .A1(n10), .A2(East_in[0]), .B1(n95), .B2(West_in[0]), .Q(n49)
         );
  AOI22X1 U9 ( .A1(n105), .A2(Local_in[0]), .B1(n3), .B2(North_in[0]), .Q(n48)
         );
  AOI22X1 U10 ( .A1(n10), .A2(East_in[1]), .B1(n95), .B2(West_in[1]), .Q(n18)
         );
  AOI22X1 U11 ( .A1(n10), .A2(East_in[2]), .B1(n95), .B2(West_in[2]), .Q(n21)
         );
  AOI22X1 U12 ( .A1(n10), .A2(East_in[4]), .B1(n95), .B2(West_in[4]), .Q(n14)
         );
  AOI22X1 U13 ( .A1(n10), .A2(East_in[5]), .B1(n95), .B2(West_in[5]), .Q(n11)
         );
  AOI22X1 U14 ( .A1(n10), .A2(East_in[6]), .B1(n95), .B2(West_in[6]), .Q(n24)
         );
  AOI22X1 U15 ( .A1(n10), .A2(East_in[7]), .B1(n95), .B2(West_in[7]), .Q(n89)
         );
  AOI22X1 U16 ( .A1(n105), .A2(Local_in[7]), .B1(n3), .B2(North_in[7]), .Q(n90) );
  AOI22X1 U17 ( .A1(n105), .A2(Local_in[8]), .B1(n3), .B2(North_in[8]), .Q(n34) );
  AOI22X1 U18 ( .A1(n10), .A2(East_in[9]), .B1(n95), .B2(West_in[9]), .Q(n68)
         );
  AOI22X1 U19 ( .A1(n105), .A2(Local_in[9]), .B1(n3), .B2(North_in[9]), .Q(n69) );
  AOI22X1 U20 ( .A1(n10), .A2(East_in[10]), .B1(n95), .B2(West_in[10]), .Q(n80) );
  AOI22X1 U21 ( .A1(n105), .A2(Local_in[10]), .B1(n3), .B2(North_in[10]), .Q(
        n81) );
  AOI22X1 U22 ( .A1(n10), .A2(East_in[11]), .B1(n95), .B2(West_in[11]), .Q(n36) );
  AOI22X1 U23 ( .A1(n105), .A2(Local_in[11]), .B1(n3), .B2(North_in[11]), .Q(
        n37) );
  AOI22X1 U24 ( .A1(n10), .A2(East_in[12]), .B1(n95), .B2(West_in[12]), .Q(
        n102) );
  AOI22X1 U25 ( .A1(n105), .A2(Local_in[12]), .B1(n3), .B2(North_in[12]), .Q(
        n103) );
  AOI22X1 U26 ( .A1(n10), .A2(East_in[14]), .B1(n95), .B2(West_in[14]), .Q(n42) );
  AOI22X1 U27 ( .A1(n105), .A2(Local_in[14]), .B1(n3), .B2(North_in[14]), .Q(
        n43) );
  AOI22X1 U28 ( .A1(n10), .A2(East_in[15]), .B1(n95), .B2(West_in[15]), .Q(
        n109) );
  AOI22X1 U29 ( .A1(n10), .A2(East_in[16]), .B1(n95), .B2(West_in[16]), .Q(n53) );
  AOI22X1 U30 ( .A1(n105), .A2(Local_in[16]), .B1(n3), .B2(North_in[16]), .Q(
        n54) );
  AOI22X1 U31 ( .A1(n10), .A2(East_in[17]), .B1(n95), .B2(West_in[17]), .Q(n65) );
  AOI22X1 U32 ( .A1(n105), .A2(Local_in[17]), .B1(n3), .B2(North_in[17]), .Q(
        n66) );
  AOI22X1 U33 ( .A1(n105), .A2(Local_in[18]), .B1(n3), .B2(North_in[18]), .Q(
        n87) );
  AOI22X1 U34 ( .A1(n10), .A2(East_in[19]), .B1(n95), .B2(West_in[19]), .Q(n83) );
  AOI22X1 U35 ( .A1(n105), .A2(Local_in[19]), .B1(n3), .B2(North_in[19]), .Q(
        n84) );
  AOI22X1 U36 ( .A1(n10), .A2(East_in[20]), .B1(n95), .B2(West_in[20]), .Q(n77) );
  AOI22X1 U37 ( .A1(n105), .A2(Local_in[20]), .B1(n3), .B2(North_in[20]), .Q(
        n78) );
  AOI22X1 U38 ( .A1(n105), .A2(Local_in[21]), .B1(n3), .B2(North_in[21]), .Q(
        n97) );
  AOI22X1 U39 ( .A1(n105), .A2(Local_in[22]), .B1(n3), .B2(North_in[22]), .Q(
        n57) );
  NAND3X1 U40 ( .A(n73), .B(n72), .C(n71), .Q(Data_out[23]) );
  AOI22X1 U41 ( .A1(n10), .A2(East_in[24]), .B1(n95), .B2(West_in[24]), .Q(n59) );
  AOI22X1 U42 ( .A1(n105), .A2(Local_in[24]), .B1(n3), .B2(North_in[24]), .Q(
        n60) );
  AOI22X1 U43 ( .A1(n10), .A2(East_in[25]), .B1(n95), .B2(West_in[25]), .Q(n62) );
  AOI22X1 U44 ( .A1(n105), .A2(Local_in[25]), .B1(n3), .B2(North_in[25]), .Q(
        n63) );
  AOI22X1 U45 ( .A1(n10), .A2(East_in[26]), .B1(n95), .B2(West_in[26]), .Q(n92) );
  AOI22X1 U46 ( .A1(n105), .A2(Local_in[26]), .B1(n3), .B2(North_in[26]), .Q(
        n93) );
  AOI22X1 U47 ( .A1(n10), .A2(East_in[27]), .B1(n95), .B2(West_in[27]), .Q(n74) );
  AOI22X1 U48 ( .A1(n105), .A2(Local_in[27]), .B1(n3), .B2(North_in[27]), .Q(
        n75) );
  AOI22X1 U49 ( .A1(n105), .A2(Local_in[28]), .B1(n3), .B2(North_in[28]), .Q(
        n100) );
  AOI22X1 U50 ( .A1(n10), .A2(East_in[29]), .B1(n95), .B2(West_in[29]), .Q(
        n106) );
  AOI22X1 U51 ( .A1(n105), .A2(Local_in[29]), .B1(n3), .B2(North_in[29]), .Q(
        n107) );
  AOI22X1 U52 ( .A1(n10), .A2(East_in[31]), .B1(n95), .B2(West_in[31]), .Q(n39) );
  AOI22X1 U53 ( .A1(n105), .A2(Local_in[31]), .B1(n3), .B2(North_in[31]), .Q(
        n40) );
  AOI22X1 U54 ( .A1(n105), .A2(Local_in[13]), .B1(n3), .B2(North_in[13]), .Q(
        n46) );
  AOI22X1 U55 ( .A1(n105), .A2(Local_in[15]), .B1(n3), .B2(North_in[15]), .Q(
        n110) );
  NOR2X4 U56 ( .A(sel[1]), .B(n6), .Q(n105) );
  AOI22X1 U57 ( .A1(n10), .A2(East_in[3]), .B1(n95), .B2(West_in[3]), .Q(n27)
         );
  AOI22X1 U58 ( .A1(n10), .A2(East_in[8]), .B1(n95), .B2(West_in[8]), .Q(n33)
         );
  AOI22X1 U59 ( .A1(n10), .A2(East_in[13]), .B1(n95), .B2(West_in[13]), .Q(n45) );
  AOI22X1 U60 ( .A1(n10), .A2(East_in[18]), .B1(n95), .B2(West_in[18]), .Q(n86) );
  AOI22X1 U61 ( .A1(n105), .A2(Local_in[23]), .B1(n3), .B2(North_in[23]), .Q(
        n72) );
  AOI22X1 U62 ( .A1(n10), .A2(East_in[28]), .B1(n95), .B2(West_in[28]), .Q(n99) );
  OAI211X1 U63 ( .A1(n51), .A2(n50), .B1(n49), .C1(n48), .Q(Data_out[0]) );
  NAND3X1 U64 ( .A(n70), .B(n69), .C(n68), .Q(Data_out[9]) );
  NAND3X1 U65 ( .A(n61), .B(n60), .C(n59), .Q(Data_out[24]) );
  INVXL U66 ( .A(sel[0]), .Q(n4) );
  NAND2XL U67 ( .A(South_in[5]), .B(n17), .Q(n13) );
  NAND2XL U68 ( .A(sel[0]), .B(n5), .Q(n6) );
  NAND2XL U69 ( .A(sel[3]), .B(n8), .Q(n7) );
  NAND2XL U70 ( .A(sel[2]), .B(n8), .Q(n9) );
  NOR2X3 U71 ( .A(sel[3]), .B(n9), .Q(n95) );
  AOI22X1 U72 ( .A1(n105), .A2(Local_in[5]), .B1(n52), .B2(North_in[5]), .Q(
        n12) );
  NAND3X1 U73 ( .A(n13), .B(n12), .C(n11), .Q(Data_out[5]) );
  NAND2XL U74 ( .A(South_in[4]), .B(n17), .Q(n16) );
  AOI22X1 U75 ( .A1(n105), .A2(Local_in[4]), .B1(n52), .B2(North_in[4]), .Q(
        n15) );
  NAND3X1 U76 ( .A(n16), .B(n15), .C(n14), .Q(Data_out[4]) );
  NAND2XL U77 ( .A(South_in[1]), .B(n17), .Q(n20) );
  AOI22X1 U78 ( .A1(n105), .A2(Local_in[1]), .B1(n52), .B2(North_in[1]), .Q(
        n19) );
  NAND3X1 U79 ( .A(n20), .B(n19), .C(n18), .Q(Data_out[1]) );
  NAND2XL U80 ( .A(South_in[2]), .B(n17), .Q(n23) );
  AOI22X1 U81 ( .A1(n105), .A2(Local_in[2]), .B1(n52), .B2(North_in[2]), .Q(
        n22) );
  NAND3X1 U82 ( .A(n23), .B(n22), .C(n21), .Q(Data_out[2]) );
  NAND2XL U83 ( .A(South_in[6]), .B(n17), .Q(n26) );
  AOI22X1 U84 ( .A1(n105), .A2(Local_in[6]), .B1(n52), .B2(North_in[6]), .Q(
        n25) );
  NAND3X1 U85 ( .A(n26), .B(n25), .C(n24), .Q(Data_out[6]) );
  NAND2XL U86 ( .A(South_in[3]), .B(n17), .Q(n29) );
  AOI22X1 U87 ( .A1(n105), .A2(Local_in[3]), .B1(n52), .B2(North_in[3]), .Q(
        n28) );
  NAND3X1 U88 ( .A(n29), .B(n28), .C(n27), .Q(Data_out[3]) );
  NAND2XL U89 ( .A(South_in[30]), .B(n17), .Q(n32) );
  AOI22X1 U90 ( .A1(n105), .A2(Local_in[30]), .B1(n3), .B2(North_in[30]), .Q(
        n31) );
  AOI22X1 U91 ( .A1(n10), .A2(East_in[30]), .B1(n95), .B2(West_in[30]), .Q(n30) );
  NAND3X1 U92 ( .A(n32), .B(n31), .C(n30), .Q(Data_out[30]) );
  NAND2XL U93 ( .A(South_in[8]), .B(n17), .Q(n35) );
  NAND3X1 U94 ( .A(n35), .B(n34), .C(n33), .Q(Data_out[8]) );
  NAND2XL U95 ( .A(South_in[11]), .B(n17), .Q(n38) );
  NAND3X1 U96 ( .A(n38), .B(n37), .C(n36), .Q(Data_out[11]) );
  NAND2XL U97 ( .A(South_in[31]), .B(n17), .Q(n41) );
  NAND3X1 U98 ( .A(n41), .B(n40), .C(n39), .Q(Data_out[31]) );
  NAND2XL U99 ( .A(South_in[14]), .B(n17), .Q(n44) );
  NAND3X1 U100 ( .A(n44), .B(n43), .C(n42), .Q(Data_out[14]) );
  NAND2XL U101 ( .A(South_in[13]), .B(n17), .Q(n47) );
  NAND3X1 U102 ( .A(n47), .B(n46), .C(n45), .Q(Data_out[13]) );
  INVXL U103 ( .A(South_in[0]), .Q(n50) );
  NAND2XL U104 ( .A(South_in[16]), .B(n17), .Q(n55) );
  NAND3X1 U105 ( .A(n55), .B(n54), .C(n53), .Q(Data_out[16]) );
  NAND2XL U106 ( .A(South_in[22]), .B(n17), .Q(n58) );
  AOI22X1 U107 ( .A1(n10), .A2(East_in[22]), .B1(n95), .B2(West_in[22]), .Q(
        n56) );
  NAND3X1 U108 ( .A(n58), .B(n57), .C(n56), .Q(Data_out[22]) );
  NAND2XL U109 ( .A(South_in[24]), .B(n17), .Q(n61) );
  NAND2XL U110 ( .A(South_in[25]), .B(n17), .Q(n64) );
  NAND3X1 U111 ( .A(n64), .B(n63), .C(n62), .Q(Data_out[25]) );
  NAND2XL U112 ( .A(South_in[17]), .B(n17), .Q(n67) );
  NAND3X1 U113 ( .A(n67), .B(n66), .C(n65), .Q(Data_out[17]) );
  NAND2XL U114 ( .A(South_in[9]), .B(n17), .Q(n70) );
  NAND2XL U115 ( .A(South_in[23]), .B(n17), .Q(n73) );
  AOI22X1 U116 ( .A1(n10), .A2(East_in[23]), .B1(n95), .B2(West_in[23]), .Q(
        n71) );
  NAND2XL U117 ( .A(South_in[27]), .B(n17), .Q(n76) );
  NAND3X1 U118 ( .A(n76), .B(n75), .C(n74), .Q(Data_out[27]) );
  NAND2XL U119 ( .A(South_in[20]), .B(n17), .Q(n79) );
  NAND3X1 U120 ( .A(n79), .B(n78), .C(n77), .Q(Data_out[20]) );
  NAND2XL U121 ( .A(South_in[10]), .B(n17), .Q(n82) );
  NAND3X1 U122 ( .A(n82), .B(n81), .C(n80), .Q(Data_out[10]) );
  NAND2XL U123 ( .A(South_in[19]), .B(n17), .Q(n85) );
  NAND3X1 U124 ( .A(n85), .B(n84), .C(n83), .Q(Data_out[19]) );
  NAND2XL U125 ( .A(South_in[18]), .B(n17), .Q(n88) );
  NAND3X1 U126 ( .A(n88), .B(n87), .C(n86), .Q(Data_out[18]) );
  NAND2XL U127 ( .A(South_in[7]), .B(n17), .Q(n91) );
  NAND3X1 U128 ( .A(n91), .B(n90), .C(n89), .Q(Data_out[7]) );
  NAND2XL U129 ( .A(South_in[26]), .B(n17), .Q(n94) );
  NAND3X1 U130 ( .A(n94), .B(n93), .C(n92), .Q(Data_out[26]) );
  NAND2XL U131 ( .A(South_in[21]), .B(n17), .Q(n98) );
  AOI22X1 U132 ( .A1(n10), .A2(East_in[21]), .B1(n95), .B2(West_in[21]), .Q(
        n96) );
  NAND3X1 U133 ( .A(n98), .B(n97), .C(n96), .Q(Data_out[21]) );
  NAND2XL U134 ( .A(South_in[28]), .B(n17), .Q(n101) );
  NAND3X1 U135 ( .A(n101), .B(n100), .C(n99), .Q(Data_out[28]) );
  NAND2XL U136 ( .A(South_in[12]), .B(n17), .Q(n104) );
  NAND3X1 U137 ( .A(n104), .B(n103), .C(n102), .Q(Data_out[12]) );
  NAND2XL U138 ( .A(South_in[29]), .B(n17), .Q(n108) );
  NAND3X1 U139 ( .A(n108), .B(n107), .C(n106), .Q(Data_out[29]) );
  NAND2XL U140 ( .A(South_in[15]), .B(n17), .Q(n111) );
  NAND3X1 U141 ( .A(n111), .B(n110), .C(n109), .Q(Data_out[15]) );
endmodule


module XBAR_DATA_WIDTH32_3 ( North_in, East_in, West_in, South_in, Local_in, 
        sel, Data_out );
  input [31:0] North_in;
  input [31:0] East_in;
  input [31:0] West_in;
  input [31:0] South_in;
  input [31:0] Local_in;
  input [4:0] sel;
  output [31:0] Data_out;
  wire   N12, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76;
  assign N12 = sel[2];

  NOR2XL U1 ( .A(sel[1]), .B(sel[0]), .Q(n3) );
  NOR2X3 U2 ( .A(sel[4]), .B(n2), .Q(n73) );
  AOI22X1 U3 ( .A1(n73), .A2(West_in[31]), .B1(North_in[31]), .B2(n72), .Q(n76) );
  CLKBUFX2 U4 ( .A(n13), .Q(n1) );
  NAND2XL U5 ( .A(N12), .B(n3), .Q(n2) );
  NOR4X2 U6 ( .A(N12), .B(sel[4]), .C(sel[0]), .D(n8), .Q(n13) );
  INVXL U7 ( .A(n3), .Q(n6) );
  AOI22X1 U8 ( .A1(n73), .A2(West_in[0]), .B1(North_in[0]), .B2(n72), .Q(n19)
         );
  AOI22X1 U9 ( .A1(n73), .A2(West_in[1]), .B1(North_in[1]), .B2(n72), .Q(n21)
         );
  AOI22X1 U10 ( .A1(n73), .A2(West_in[2]), .B1(North_in[2]), .B2(n72), .Q(n23)
         );
  AOI22X1 U11 ( .A1(n73), .A2(West_in[3]), .B1(North_in[3]), .B2(n72), .Q(n10)
         );
  AOI22X1 U12 ( .A1(n73), .A2(West_in[4]), .B1(North_in[4]), .B2(n72), .Q(n27)
         );
  AOI22X1 U13 ( .A1(n73), .A2(West_in[5]), .B1(North_in[5]), .B2(n72), .Q(n29)
         );
  AOI22X1 U14 ( .A1(n73), .A2(West_in[6]), .B1(North_in[6]), .B2(n72), .Q(n49)
         );
  AOI22X1 U15 ( .A1(n73), .A2(West_in[8]), .B1(North_in[8]), .B2(n72), .Q(n53)
         );
  AOI22X1 U16 ( .A1(n73), .A2(West_in[9]), .B1(North_in[9]), .B2(n72), .Q(n55)
         );
  AOI22X1 U17 ( .A1(n73), .A2(West_in[10]), .B1(North_in[10]), .B2(n72), .Q(
        n25) );
  AOI22X1 U18 ( .A1(n74), .A2(Local_in[11]), .B1(n1), .B2(South_in[11]), .Q(
        n58) );
  AOI22X1 U19 ( .A1(n73), .A2(West_in[11]), .B1(North_in[11]), .B2(n72), .Q(
        n59) );
  AOI22X1 U20 ( .A1(n74), .A2(Local_in[12]), .B1(n1), .B2(South_in[12]), .Q(
        n46) );
  AOI22X1 U21 ( .A1(n73), .A2(West_in[12]), .B1(North_in[12]), .B2(n72), .Q(
        n47) );
  AOI22X1 U22 ( .A1(n74), .A2(Local_in[13]), .B1(n1), .B2(South_in[13]), .Q(
        n30) );
  AOI22X1 U23 ( .A1(n74), .A2(Local_in[14]), .B1(n1), .B2(South_in[14]), .Q(
        n11) );
  AOI22X1 U24 ( .A1(n73), .A2(West_in[16]), .B1(North_in[16]), .B2(n72), .Q(
        n17) );
  AOI22X1 U25 ( .A1(n74), .A2(Local_in[17]), .B1(n1), .B2(South_in[17]), .Q(
        n36) );
  AOI22X1 U26 ( .A1(n73), .A2(West_in[17]), .B1(North_in[17]), .B2(n72), .Q(
        n37) );
  AOI22X1 U27 ( .A1(n74), .A2(Local_in[18]), .B1(n1), .B2(South_in[18]), .Q(
        n38) );
  AOI22X1 U28 ( .A1(n73), .A2(West_in[18]), .B1(North_in[18]), .B2(n72), .Q(
        n39) );
  AOI22X1 U29 ( .A1(n74), .A2(Local_in[19]), .B1(n1), .B2(South_in[19]), .Q(
        n40) );
  AOI22X1 U30 ( .A1(n73), .A2(West_in[19]), .B1(North_in[19]), .B2(n72), .Q(
        n41) );
  AOI22X1 U31 ( .A1(n74), .A2(Local_in[20]), .B1(n1), .B2(South_in[20]), .Q(
        n42) );
  AOI22X1 U32 ( .A1(n73), .A2(West_in[20]), .B1(North_in[20]), .B2(n72), .Q(
        n43) );
  AOI22X1 U33 ( .A1(n74), .A2(Local_in[21]), .B1(n1), .B2(South_in[21]), .Q(
        n44) );
  AOI22X1 U34 ( .A1(n73), .A2(West_in[21]), .B1(North_in[21]), .B2(n72), .Q(
        n45) );
  AOI22X1 U35 ( .A1(n73), .A2(West_in[22]), .B1(North_in[22]), .B2(n72), .Q(
        n33) );
  AOI22X1 U36 ( .A1(n74), .A2(Local_in[23]), .B1(n1), .B2(South_in[23]), .Q(
        n66) );
  AOI22X1 U37 ( .A1(n73), .A2(West_in[23]), .B1(North_in[23]), .B2(n72), .Q(
        n67) );
  AOI22X1 U38 ( .A1(n74), .A2(Local_in[24]), .B1(n1), .B2(South_in[24]), .Q(
        n60) );
  AOI22X1 U39 ( .A1(n73), .A2(West_in[24]), .B1(North_in[24]), .B2(n72), .Q(
        n61) );
  AOI22X1 U40 ( .A1(n74), .A2(Local_in[25]), .B1(n1), .B2(South_in[25]), .Q(
        n68) );
  AOI22X1 U41 ( .A1(n73), .A2(West_in[25]), .B1(North_in[25]), .B2(n72), .Q(
        n69) );
  AOI22X1 U42 ( .A1(n74), .A2(Local_in[26]), .B1(n1), .B2(South_in[26]), .Q(
        n64) );
  AOI22X1 U43 ( .A1(n73), .A2(West_in[26]), .B1(North_in[26]), .B2(n72), .Q(
        n65) );
  AOI22X1 U44 ( .A1(n74), .A2(Local_in[27]), .B1(n1), .B2(South_in[27]), .Q(
        n56) );
  AOI22X1 U45 ( .A1(n73), .A2(West_in[27]), .B1(North_in[27]), .B2(n72), .Q(
        n57) );
  AOI22X1 U46 ( .A1(n74), .A2(Local_in[28]), .B1(n1), .B2(South_in[28]), .Q(
        n34) );
  AOI22X1 U47 ( .A1(n73), .A2(West_in[28]), .B1(North_in[28]), .B2(n72), .Q(
        n35) );
  AOI22X1 U48 ( .A1(n74), .A2(Local_in[29]), .B1(n1), .B2(South_in[29]), .Q(
        n70) );
  AOI22X1 U49 ( .A1(n74), .A2(Local_in[15]), .B1(n1), .B2(South_in[15]), .Q(
        n14) );
  AOI22X1 U50 ( .A1(n74), .A2(Local_in[16]), .B1(n1), .B2(South_in[16]), .Q(
        n16) );
  AOI22X1 U51 ( .A1(n73), .A2(West_in[13]), .B1(North_in[13]), .B2(n72), .Q(
        n31) );
  AOI22X1 U52 ( .A1(n73), .A2(West_in[15]), .B1(North_in[15]), .B2(n72), .Q(
        n15) );
  AOI22X1 U53 ( .A1(n73), .A2(West_in[7]), .B1(North_in[7]), .B2(n72), .Q(n51)
         );
  AOI22X1 U54 ( .A1(n73), .A2(West_in[14]), .B1(North_in[14]), .B2(n72), .Q(
        n12) );
  AOI22X1 U55 ( .A1(n74), .A2(Local_in[22]), .B1(n1), .B2(South_in[22]), .Q(
        n32) );
  AOI22X1 U56 ( .A1(n73), .A2(West_in[29]), .B1(North_in[29]), .B2(n72), .Q(
        n71) );
  NAND2XL U57 ( .A(n6), .B(N12), .Q(n5) );
  AOI21X1 U58 ( .A1(sel[1]), .A2(sel[0]), .B1(sel[4]), .Q(n4) );
  OAI211X6 U59 ( .A1(n6), .A2(N12), .B1(n5), .C1(n4), .Q(n72) );
  INVXL U60 ( .A(sel[0]), .Q(n7) );
  NOR4X3 U61 ( .A(N12), .B(sel[4]), .C(sel[1]), .D(n7), .Q(n74) );
  INVXL U62 ( .A(sel[1]), .Q(n8) );
  AOI22X1 U63 ( .A1(n74), .A2(Local_in[3]), .B1(n1), .B2(South_in[3]), .Q(n9)
         );
  NAND2XL U64 ( .A(n10), .B(n9), .Q(Data_out[3]) );
  NAND2XL U65 ( .A(n12), .B(n11), .Q(Data_out[14]) );
  NAND2XL U66 ( .A(n15), .B(n14), .Q(Data_out[15]) );
  NAND2XL U67 ( .A(n17), .B(n16), .Q(Data_out[16]) );
  AOI22X1 U68 ( .A1(n74), .A2(Local_in[0]), .B1(n1), .B2(South_in[0]), .Q(n18)
         );
  NAND2XL U69 ( .A(n19), .B(n18), .Q(Data_out[0]) );
  AOI22X1 U70 ( .A1(n74), .A2(Local_in[1]), .B1(n1), .B2(South_in[1]), .Q(n20)
         );
  NAND2XL U71 ( .A(n21), .B(n20), .Q(Data_out[1]) );
  AOI22X1 U72 ( .A1(n74), .A2(Local_in[2]), .B1(n1), .B2(South_in[2]), .Q(n22)
         );
  NAND2XL U73 ( .A(n23), .B(n22), .Q(Data_out[2]) );
  AOI22X1 U74 ( .A1(n74), .A2(Local_in[10]), .B1(n1), .B2(South_in[10]), .Q(
        n24) );
  NAND2XL U75 ( .A(n25), .B(n24), .Q(Data_out[10]) );
  AOI22X1 U76 ( .A1(n74), .A2(Local_in[4]), .B1(n1), .B2(South_in[4]), .Q(n26)
         );
  NAND2XL U77 ( .A(n27), .B(n26), .Q(Data_out[4]) );
  AOI22X1 U78 ( .A1(n74), .A2(Local_in[5]), .B1(n1), .B2(South_in[5]), .Q(n28)
         );
  NAND2XL U79 ( .A(n29), .B(n28), .Q(Data_out[5]) );
  NAND2XL U80 ( .A(n31), .B(n30), .Q(Data_out[13]) );
  NAND2XL U81 ( .A(n33), .B(n32), .Q(Data_out[22]) );
  NAND2XL U82 ( .A(n35), .B(n34), .Q(Data_out[28]) );
  NAND2XL U83 ( .A(n37), .B(n36), .Q(Data_out[17]) );
  NAND2XL U84 ( .A(n39), .B(n38), .Q(Data_out[18]) );
  NAND2XL U85 ( .A(n41), .B(n40), .Q(Data_out[19]) );
  NAND2XL U86 ( .A(n43), .B(n42), .Q(Data_out[20]) );
  NAND2XL U87 ( .A(n45), .B(n44), .Q(Data_out[21]) );
  NAND2XL U88 ( .A(n47), .B(n46), .Q(Data_out[12]) );
  AOI22X1 U89 ( .A1(n74), .A2(Local_in[6]), .B1(n1), .B2(South_in[6]), .Q(n48)
         );
  NAND2XL U90 ( .A(n49), .B(n48), .Q(Data_out[6]) );
  AOI22X1 U91 ( .A1(n74), .A2(Local_in[7]), .B1(n1), .B2(South_in[7]), .Q(n50)
         );
  NAND2XL U92 ( .A(n51), .B(n50), .Q(Data_out[7]) );
  AOI22X1 U93 ( .A1(n74), .A2(Local_in[8]), .B1(n1), .B2(South_in[8]), .Q(n52)
         );
  NAND2XL U94 ( .A(n53), .B(n52), .Q(Data_out[8]) );
  AOI22X1 U95 ( .A1(n74), .A2(Local_in[9]), .B1(n1), .B2(South_in[9]), .Q(n54)
         );
  NAND2XL U96 ( .A(n55), .B(n54), .Q(Data_out[9]) );
  NAND2XL U97 ( .A(n57), .B(n56), .Q(Data_out[27]) );
  NAND2XL U98 ( .A(n59), .B(n58), .Q(Data_out[11]) );
  NAND2XL U99 ( .A(n61), .B(n60), .Q(Data_out[24]) );
  AOI22X1 U100 ( .A1(n73), .A2(West_in[30]), .B1(North_in[30]), .B2(n72), .Q(
        n63) );
  AOI22X1 U101 ( .A1(n74), .A2(Local_in[30]), .B1(n1), .B2(South_in[30]), .Q(
        n62) );
  NAND2XL U102 ( .A(n63), .B(n62), .Q(Data_out[30]) );
  NAND2XL U103 ( .A(n65), .B(n64), .Q(Data_out[26]) );
  NAND2XL U104 ( .A(n67), .B(n66), .Q(Data_out[23]) );
  NAND2XL U105 ( .A(n69), .B(n68), .Q(Data_out[25]) );
  NAND2XL U106 ( .A(n71), .B(n70), .Q(Data_out[29]) );
  AOI22X1 U107 ( .A1(n74), .A2(Local_in[31]), .B1(n1), .B2(South_in[31]), .Q(
        n75) );
  NAND2XL U108 ( .A(n76), .B(n75), .Q(Data_out[31]) );
endmodule


module XBAR_DATA_WIDTH32_2 ( North_in, East_in, West_in, South_in, Local_in, 
        sel, Data_out );
  input [31:0] North_in;
  input [31:0] East_in;
  input [31:0] West_in;
  input [31:0] South_in;
  input [31:0] Local_in;
  input [4:0] sel;
  output [31:0] Data_out;
  wire   N12, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77;
  assign N12 = sel[3];

  INVXL U1 ( .A(n2), .Q(n5) );
  AOI21X2 U2 ( .A1(sel[1]), .A2(sel[0]), .B1(sel[4]), .Q(n3) );
  CLKBUFX2 U3 ( .A(n74), .Q(n67) );
  BUFX2 U4 ( .A(n38), .Q(n75) );
  NOR2X3 U5 ( .A(sel[4]), .B(n1), .Q(n73) );
  AOI22X1 U6 ( .A1(n73), .A2(East_in[0]), .B1(North_in[0]), .B2(n72), .Q(n69)
         );
  AOI22X1 U7 ( .A1(n75), .A2(Local_in[0]), .B1(n67), .B2(South_in[0]), .Q(n68)
         );
  AOI22X1 U8 ( .A1(n75), .A2(Local_in[1]), .B1(n67), .B2(South_in[1]), .Q(n65)
         );
  AOI22X1 U9 ( .A1(n73), .A2(East_in[2]), .B1(North_in[2]), .B2(n72), .Q(n64)
         );
  AOI22X1 U10 ( .A1(n75), .A2(Local_in[2]), .B1(n67), .B2(South_in[2]), .Q(n63) );
  AOI22X1 U11 ( .A1(n73), .A2(East_in[3]), .B1(North_in[3]), .B2(n72), .Q(n62)
         );
  AOI22X1 U12 ( .A1(n75), .A2(Local_in[3]), .B1(n67), .B2(South_in[3]), .Q(n61) );
  AOI22X1 U13 ( .A1(n73), .A2(East_in[4]), .B1(North_in[4]), .B2(n72), .Q(n60)
         );
  AOI22X1 U14 ( .A1(n75), .A2(Local_in[4]), .B1(n67), .B2(South_in[4]), .Q(n59) );
  AOI22X1 U15 ( .A1(n73), .A2(East_in[5]), .B1(North_in[5]), .B2(n72), .Q(n42)
         );
  AOI22X1 U16 ( .A1(n75), .A2(Local_in[5]), .B1(n67), .B2(South_in[5]), .Q(n41) );
  AOI22X1 U17 ( .A1(n73), .A2(East_in[6]), .B1(North_in[6]), .B2(n72), .Q(n58)
         );
  AOI22X1 U18 ( .A1(n75), .A2(Local_in[6]), .B1(n67), .B2(South_in[6]), .Q(n57) );
  AOI22X1 U19 ( .A1(n73), .A2(East_in[7]), .B1(North_in[7]), .B2(n72), .Q(n56)
         );
  AOI22X1 U20 ( .A1(n75), .A2(Local_in[7]), .B1(n67), .B2(South_in[7]), .Q(n55) );
  AOI22X1 U21 ( .A1(n73), .A2(East_in[8]), .B1(North_in[8]), .B2(n72), .Q(n54)
         );
  AOI22X1 U22 ( .A1(n75), .A2(Local_in[8]), .B1(n67), .B2(South_in[8]), .Q(n53) );
  AOI22X1 U23 ( .A1(n73), .A2(East_in[9]), .B1(North_in[9]), .B2(n72), .Q(n52)
         );
  AOI22X1 U24 ( .A1(n73), .A2(East_in[10]), .B1(North_in[10]), .B2(n72), .Q(
        n50) );
  AOI22X1 U25 ( .A1(n75), .A2(Local_in[10]), .B1(n67), .B2(South_in[10]), .Q(
        n49) );
  AOI22X1 U26 ( .A1(n73), .A2(East_in[11]), .B1(North_in[11]), .B2(n72), .Q(
        n48) );
  AOI22X1 U27 ( .A1(n75), .A2(Local_in[11]), .B1(n67), .B2(South_in[11]), .Q(
        n47) );
  AOI22X1 U28 ( .A1(n73), .A2(East_in[12]), .B1(North_in[12]), .B2(n72), .Q(
        n46) );
  AOI22X1 U29 ( .A1(n75), .A2(Local_in[12]), .B1(n67), .B2(South_in[12]), .Q(
        n45) );
  AOI22X1 U30 ( .A1(n75), .A2(Local_in[13]), .B1(n67), .B2(South_in[13]), .Q(
        n43) );
  AOI22X1 U31 ( .A1(n73), .A2(East_in[14]), .B1(North_in[14]), .B2(n72), .Q(
        n40) );
  AOI22X1 U32 ( .A1(n75), .A2(Local_in[14]), .B1(n67), .B2(South_in[14]), .Q(
        n39) );
  AOI22X1 U33 ( .A1(n73), .A2(East_in[17]), .B1(North_in[17]), .B2(n72), .Q(
        n33) );
  AOI22X1 U34 ( .A1(n73), .A2(East_in[18]), .B1(North_in[18]), .B2(n72), .Q(
        n31) );
  AOI22X1 U35 ( .A1(n73), .A2(East_in[19]), .B1(North_in[19]), .B2(n72), .Q(
        n29) );
  AOI22X1 U36 ( .A1(n38), .A2(Local_in[19]), .B1(n67), .B2(South_in[19]), .Q(
        n28) );
  AOI22X1 U37 ( .A1(n73), .A2(East_in[20]), .B1(North_in[20]), .B2(n72), .Q(
        n37) );
  AOI22X1 U38 ( .A1(n38), .A2(Local_in[20]), .B1(n67), .B2(South_in[20]), .Q(
        n36) );
  AOI22X1 U39 ( .A1(n73), .A2(East_in[21]), .B1(North_in[21]), .B2(n72), .Q(
        n25) );
  AOI22X1 U40 ( .A1(n38), .A2(Local_in[21]), .B1(n67), .B2(South_in[21]), .Q(
        n24) );
  AOI22X1 U41 ( .A1(n73), .A2(East_in[22]), .B1(North_in[22]), .B2(n72), .Q(
        n21) );
  AOI22X1 U42 ( .A1(n38), .A2(Local_in[22]), .B1(n67), .B2(South_in[22]), .Q(
        n20) );
  AOI22X1 U43 ( .A1(n73), .A2(East_in[23]), .B1(North_in[23]), .B2(n72), .Q(
        n19) );
  AOI22X1 U44 ( .A1(n38), .A2(Local_in[23]), .B1(n67), .B2(South_in[23]), .Q(
        n18) );
  AOI22X1 U45 ( .A1(n73), .A2(East_in[24]), .B1(North_in[24]), .B2(n72), .Q(
        n27) );
  AOI22X1 U46 ( .A1(n73), .A2(East_in[25]), .B1(North_in[25]), .B2(n72), .Q(
        n15) );
  AOI22X1 U47 ( .A1(n38), .A2(Local_in[25]), .B1(n67), .B2(South_in[25]), .Q(
        n14) );
  AOI22X1 U48 ( .A1(n73), .A2(East_in[26]), .B1(North_in[26]), .B2(n72), .Q(
        n23) );
  AOI22X1 U49 ( .A1(n38), .A2(Local_in[26]), .B1(n67), .B2(South_in[26]), .Q(
        n22) );
  AOI22X1 U50 ( .A1(n73), .A2(East_in[27]), .B1(North_in[27]), .B2(n72), .Q(
        n17) );
  AOI22X1 U51 ( .A1(n38), .A2(Local_in[27]), .B1(n67), .B2(South_in[27]), .Q(
        n16) );
  AOI22X1 U52 ( .A1(n73), .A2(East_in[28]), .B1(North_in[28]), .B2(n72), .Q(
        n11) );
  AOI22X1 U53 ( .A1(n38), .A2(Local_in[28]), .B1(n67), .B2(South_in[28]), .Q(
        n10) );
  AOI22X1 U54 ( .A1(n73), .A2(East_in[29]), .B1(North_in[29]), .B2(n72), .Q(
        n13) );
  AOI22X1 U55 ( .A1(n38), .A2(Local_in[29]), .B1(n67), .B2(South_in[29]), .Q(
        n12) );
  AOI22X1 U56 ( .A1(n75), .A2(Local_in[16]), .B1(n67), .B2(South_in[16]), .Q(
        n34) );
  AOI22X1 U57 ( .A1(n73), .A2(East_in[13]), .B1(North_in[13]), .B2(n72), .Q(
        n44) );
  AOI22X1 U58 ( .A1(n73), .A2(East_in[15]), .B1(North_in[15]), .B2(n72), .Q(n9) );
  NOR2XL U59 ( .A(sel[1]), .B(sel[0]), .Q(n2) );
  AOI22X1 U60 ( .A1(n73), .A2(East_in[1]), .B1(North_in[1]), .B2(n72), .Q(n66)
         );
  AOI22X1 U61 ( .A1(n75), .A2(Local_in[9]), .B1(n67), .B2(South_in[9]), .Q(n51) );
  AOI22X1 U62 ( .A1(n73), .A2(East_in[16]), .B1(North_in[16]), .B2(n72), .Q(
        n35) );
  AOI22X1 U63 ( .A1(n38), .A2(Local_in[24]), .B1(n67), .B2(South_in[24]), .Q(
        n26) );
  AOI22X1 U64 ( .A1(n73), .A2(East_in[31]), .B1(North_in[31]), .B2(n72), .Q(
        n77) );
  NAND2XL U65 ( .A(N12), .B(n2), .Q(n1) );
  NAND2XL U66 ( .A(n5), .B(N12), .Q(n4) );
  OAI211X6 U67 ( .A1(n5), .A2(N12), .B1(n4), .C1(n3), .Q(n72) );
  INVXL U68 ( .A(sel[0]), .Q(n6) );
  NOR4X3 U69 ( .A(N12), .B(sel[4]), .C(sel[1]), .D(n6), .Q(n38) );
  INVXL U70 ( .A(sel[1]), .Q(n7) );
  NOR4X3 U71 ( .A(N12), .B(sel[4]), .C(sel[0]), .D(n7), .Q(n74) );
  AOI22X1 U72 ( .A1(n75), .A2(Local_in[15]), .B1(n74), .B2(South_in[15]), .Q(
        n8) );
  NAND2XL U73 ( .A(n9), .B(n8), .Q(Data_out[15]) );
  NAND2XL U74 ( .A(n11), .B(n10), .Q(Data_out[28]) );
  NAND2XL U75 ( .A(n13), .B(n12), .Q(Data_out[29]) );
  NAND2XL U76 ( .A(n15), .B(n14), .Q(Data_out[25]) );
  NAND2XL U77 ( .A(n17), .B(n16), .Q(Data_out[27]) );
  NAND2XL U78 ( .A(n19), .B(n18), .Q(Data_out[23]) );
  NAND2XL U79 ( .A(n21), .B(n20), .Q(Data_out[22]) );
  NAND2XL U80 ( .A(n23), .B(n22), .Q(Data_out[26]) );
  NAND2XL U81 ( .A(n25), .B(n24), .Q(Data_out[21]) );
  NAND2XL U82 ( .A(n27), .B(n26), .Q(Data_out[24]) );
  NAND2XL U83 ( .A(n29), .B(n28), .Q(Data_out[19]) );
  AOI22X1 U84 ( .A1(n38), .A2(Local_in[18]), .B1(n74), .B2(South_in[18]), .Q(
        n30) );
  NAND2XL U85 ( .A(n31), .B(n30), .Q(Data_out[18]) );
  AOI22X1 U86 ( .A1(n38), .A2(Local_in[17]), .B1(n74), .B2(South_in[17]), .Q(
        n32) );
  NAND2XL U87 ( .A(n33), .B(n32), .Q(Data_out[17]) );
  NAND2XL U88 ( .A(n35), .B(n34), .Q(Data_out[16]) );
  NAND2XL U89 ( .A(n37), .B(n36), .Q(Data_out[20]) );
  NAND2XL U90 ( .A(n40), .B(n39), .Q(Data_out[14]) );
  NAND2XL U91 ( .A(n42), .B(n41), .Q(Data_out[5]) );
  NAND2XL U92 ( .A(n44), .B(n43), .Q(Data_out[13]) );
  NAND2XL U93 ( .A(n46), .B(n45), .Q(Data_out[12]) );
  NAND2XL U94 ( .A(n48), .B(n47), .Q(Data_out[11]) );
  NAND2XL U95 ( .A(n50), .B(n49), .Q(Data_out[10]) );
  NAND2XL U96 ( .A(n52), .B(n51), .Q(Data_out[9]) );
  NAND2XL U97 ( .A(n54), .B(n53), .Q(Data_out[8]) );
  NAND2XL U98 ( .A(n56), .B(n55), .Q(Data_out[7]) );
  NAND2XL U99 ( .A(n58), .B(n57), .Q(Data_out[6]) );
  NAND2XL U100 ( .A(n60), .B(n59), .Q(Data_out[4]) );
  NAND2XL U101 ( .A(n62), .B(n61), .Q(Data_out[3]) );
  NAND2XL U102 ( .A(n64), .B(n63), .Q(Data_out[2]) );
  NAND2XL U103 ( .A(n66), .B(n65), .Q(Data_out[1]) );
  NAND2XL U104 ( .A(n69), .B(n68), .Q(Data_out[0]) );
  AOI22X1 U105 ( .A1(n73), .A2(East_in[30]), .B1(North_in[30]), .B2(n72), .Q(
        n71) );
  AOI22X1 U106 ( .A1(n75), .A2(Local_in[30]), .B1(n74), .B2(South_in[30]), .Q(
        n70) );
  NAND2XL U107 ( .A(n71), .B(n70), .Q(Data_out[30]) );
  AOI22X1 U108 ( .A1(n75), .A2(Local_in[31]), .B1(n74), .B2(South_in[31]), .Q(
        n76) );
  NAND2XL U109 ( .A(n77), .B(n76), .Q(Data_out[31]) );
endmodule


module XBAR_DATA_WIDTH32_1 ( North_in, East_in, West_in, South_in, Local_in, 
        sel, Data_out );
  input [31:0] North_in;
  input [31:0] East_in;
  input [31:0] West_in;
  input [31:0] South_in;
  input [31:0] Local_in;
  input [4:0] sel;
  output [31:0] Data_out;
  wire   N22, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78;
  assign N22 = sel[0];

  INVXL U1 ( .A(sel[2]), .Q(n9) );
  CLKBUFX2 U2 ( .A(n41), .Q(n2) );
  NOR4X2 U3 ( .A(sel[3]), .B(sel[4]), .C(sel[2]), .D(n8), .Q(n41) );
  BUFX6 U4 ( .A(n73), .Q(n1) );
  NOR4X3 U5 ( .A(sel[3]), .B(sel[4]), .C(N22), .D(n9), .Q(n42) );
  NOR2XL U6 ( .A(sel[2]), .B(N22), .Q(n4) );
  BUFX2 U7 ( .A(n42), .Q(n76) );
  AOI22X1 U8 ( .A1(n2), .A2(Local_in[0]), .B1(n76), .B2(West_in[0]), .Q(n10)
         );
  AOI22X1 U9 ( .A1(n40), .A2(East_in[0]), .B1(North_in[0]), .B2(n1), .Q(n11)
         );
  AOI22X1 U10 ( .A1(n2), .A2(Local_in[1]), .B1(n76), .B2(West_in[1]), .Q(n12)
         );
  AOI22X1 U11 ( .A1(n40), .A2(East_in[1]), .B1(North_in[1]), .B2(n1), .Q(n13)
         );
  AOI22X1 U12 ( .A1(n2), .A2(Local_in[2]), .B1(n76), .B2(West_in[2]), .Q(n14)
         );
  AOI22X1 U13 ( .A1(n40), .A2(East_in[2]), .B1(North_in[2]), .B2(n1), .Q(n15)
         );
  AOI22X1 U14 ( .A1(n2), .A2(Local_in[3]), .B1(n42), .B2(West_in[3]), .Q(n16)
         );
  AOI22X1 U15 ( .A1(n2), .A2(Local_in[4]), .B1(n76), .B2(West_in[4]), .Q(n18)
         );
  AOI22X1 U16 ( .A1(n40), .A2(East_in[4]), .B1(North_in[4]), .B2(n1), .Q(n19)
         );
  AOI22X1 U17 ( .A1(n2), .A2(Local_in[5]), .B1(n42), .B2(West_in[5]), .Q(n20)
         );
  AOI22X1 U18 ( .A1(n40), .A2(East_in[5]), .B1(North_in[5]), .B2(n1), .Q(n21)
         );
  AOI22X1 U19 ( .A1(n2), .A2(Local_in[6]), .B1(n42), .B2(West_in[6]), .Q(n22)
         );
  AOI22X1 U20 ( .A1(n40), .A2(East_in[6]), .B1(North_in[6]), .B2(n1), .Q(n23)
         );
  AOI22X1 U21 ( .A1(n2), .A2(Local_in[7]), .B1(n76), .B2(West_in[7]), .Q(n24)
         );
  AOI22X1 U22 ( .A1(n40), .A2(East_in[7]), .B1(North_in[7]), .B2(n1), .Q(n25)
         );
  AOI22X1 U23 ( .A1(n2), .A2(Local_in[8]), .B1(n76), .B2(West_in[8]), .Q(n26)
         );
  AOI22X1 U24 ( .A1(n40), .A2(East_in[8]), .B1(North_in[8]), .B2(n1), .Q(n27)
         );
  AOI22X1 U25 ( .A1(n2), .A2(Local_in[9]), .B1(n42), .B2(West_in[9]), .Q(n28)
         );
  AOI22X1 U26 ( .A1(n40), .A2(East_in[9]), .B1(North_in[9]), .B2(n1), .Q(n29)
         );
  AOI22X1 U27 ( .A1(n2), .A2(Local_in[10]), .B1(n76), .B2(West_in[10]), .Q(n30) );
  AOI22X1 U28 ( .A1(n40), .A2(East_in[10]), .B1(North_in[10]), .B2(n1), .Q(n31) );
  AOI22X1 U29 ( .A1(n40), .A2(East_in[11]), .B1(North_in[11]), .B2(n1), .Q(n33) );
  AOI22X1 U30 ( .A1(n2), .A2(Local_in[12]), .B1(n42), .B2(West_in[12]), .Q(n34) );
  AOI22X1 U31 ( .A1(n40), .A2(East_in[12]), .B1(North_in[12]), .B2(n1), .Q(n35) );
  AOI22X1 U32 ( .A1(n2), .A2(Local_in[13]), .B1(n76), .B2(West_in[13]), .Q(n36) );
  AOI22X1 U33 ( .A1(n2), .A2(Local_in[14]), .B1(n76), .B2(West_in[14]), .Q(n38) );
  AOI22X1 U34 ( .A1(n40), .A2(East_in[14]), .B1(North_in[14]), .B2(n1), .Q(n39) );
  AOI22X1 U35 ( .A1(n2), .A2(Local_in[15]), .B1(n76), .B2(West_in[15]), .Q(n43) );
  AOI22X1 U36 ( .A1(n2), .A2(Local_in[16]), .B1(n76), .B2(West_in[16]), .Q(n45) );
  AOI22X1 U37 ( .A1(n40), .A2(East_in[16]), .B1(North_in[16]), .B2(n1), .Q(n46) );
  AOI22X1 U38 ( .A1(n2), .A2(Local_in[17]), .B1(n76), .B2(West_in[17]), .Q(n47) );
  AOI22X1 U39 ( .A1(n40), .A2(East_in[17]), .B1(North_in[17]), .B2(n1), .Q(n48) );
  AOI22X1 U40 ( .A1(n2), .A2(Local_in[18]), .B1(n76), .B2(West_in[18]), .Q(n49) );
  AOI22X1 U41 ( .A1(n2), .A2(Local_in[19]), .B1(n76), .B2(West_in[19]), .Q(n51) );
  AOI22X1 U42 ( .A1(n40), .A2(East_in[19]), .B1(North_in[19]), .B2(n1), .Q(n52) );
  AOI22X1 U43 ( .A1(n2), .A2(Local_in[20]), .B1(n76), .B2(West_in[20]), .Q(n53) );
  AOI22X1 U44 ( .A1(n40), .A2(East_in[20]), .B1(North_in[20]), .B2(n1), .Q(n54) );
  AOI22X1 U45 ( .A1(n2), .A2(Local_in[21]), .B1(n76), .B2(West_in[21]), .Q(n55) );
  AOI22X1 U46 ( .A1(n40), .A2(East_in[21]), .B1(North_in[21]), .B2(n1), .Q(n56) );
  AOI22X1 U47 ( .A1(n2), .A2(Local_in[22]), .B1(n76), .B2(West_in[22]), .Q(n57) );
  AOI22X1 U48 ( .A1(n40), .A2(East_in[22]), .B1(North_in[22]), .B2(n1), .Q(n58) );
  AOI22X1 U49 ( .A1(n2), .A2(Local_in[23]), .B1(n76), .B2(West_in[23]), .Q(n59) );
  AOI22X1 U50 ( .A1(n40), .A2(East_in[23]), .B1(North_in[23]), .B2(n1), .Q(n60) );
  AOI22X1 U51 ( .A1(n2), .A2(Local_in[24]), .B1(n76), .B2(West_in[24]), .Q(n61) );
  AOI22X1 U52 ( .A1(n40), .A2(East_in[24]), .B1(North_in[24]), .B2(n1), .Q(n62) );
  AOI22X1 U53 ( .A1(n2), .A2(Local_in[25]), .B1(n76), .B2(West_in[25]), .Q(n63) );
  AOI22X1 U54 ( .A1(n40), .A2(East_in[25]), .B1(North_in[25]), .B2(n1), .Q(n64) );
  AOI22X1 U55 ( .A1(n40), .A2(East_in[26]), .B1(North_in[26]), .B2(n1), .Q(n66) );
  AOI22X1 U56 ( .A1(n2), .A2(Local_in[27]), .B1(n76), .B2(West_in[27]), .Q(n67) );
  AOI22X1 U57 ( .A1(n40), .A2(East_in[27]), .B1(North_in[27]), .B2(n1), .Q(n68) );
  AOI22X1 U58 ( .A1(n2), .A2(Local_in[28]), .B1(n76), .B2(West_in[28]), .Q(n69) );
  AOI22X1 U59 ( .A1(n40), .A2(East_in[28]), .B1(North_in[28]), .B2(n1), .Q(n70) );
  AOI22X1 U60 ( .A1(n2), .A2(Local_in[29]), .B1(n76), .B2(West_in[29]), .Q(n71) );
  AOI22X1 U61 ( .A1(n40), .A2(East_in[29]), .B1(North_in[29]), .B2(n1), .Q(n72) );
  AOI22X1 U62 ( .A1(n40), .A2(East_in[30]), .B1(North_in[30]), .B2(n1), .Q(n75) );
  AOI22X1 U63 ( .A1(n40), .A2(East_in[31]), .B1(North_in[31]), .B2(n1), .Q(n78) );
  AOI22X1 U64 ( .A1(n40), .A2(East_in[13]), .B1(North_in[13]), .B2(n1), .Q(n37) );
  AOI22X1 U65 ( .A1(n40), .A2(East_in[15]), .B1(North_in[15]), .B2(n1), .Q(n44) );
  OAI211X1 U66 ( .A1(n7), .A2(sel[3]), .B1(n6), .C1(n5), .Q(n73) );
  AOI22X1 U67 ( .A1(n40), .A2(East_in[3]), .B1(North_in[3]), .B2(n1), .Q(n17)
         );
  AOI22X1 U68 ( .A1(n2), .A2(Local_in[11]), .B1(n76), .B2(West_in[11]), .Q(n32) );
  AOI22X1 U69 ( .A1(n40), .A2(East_in[18]), .B1(North_in[18]), .B2(n1), .Q(n50) );
  AOI22X1 U70 ( .A1(n2), .A2(Local_in[26]), .B1(n76), .B2(West_in[26]), .Q(n65) );
  NAND2XL U71 ( .A(sel[3]), .B(n4), .Q(n3) );
  NOR2X3 U72 ( .A(sel[4]), .B(n3), .Q(n40) );
  INVXL U73 ( .A(n4), .Q(n7) );
  NAND2XL U74 ( .A(n7), .B(sel[3]), .Q(n6) );
  AOI21X1 U75 ( .A1(sel[2]), .A2(N22), .B1(sel[4]), .Q(n5) );
  INVXL U76 ( .A(N22), .Q(n8) );
  NAND2XL U77 ( .A(n11), .B(n10), .Q(Data_out[0]) );
  NAND2XL U78 ( .A(n13), .B(n12), .Q(Data_out[1]) );
  NAND2XL U79 ( .A(n15), .B(n14), .Q(Data_out[2]) );
  NAND2XL U80 ( .A(n17), .B(n16), .Q(Data_out[3]) );
  NAND2XL U81 ( .A(n19), .B(n18), .Q(Data_out[4]) );
  NAND2XL U82 ( .A(n21), .B(n20), .Q(Data_out[5]) );
  NAND2XL U83 ( .A(n23), .B(n22), .Q(Data_out[6]) );
  NAND2XL U84 ( .A(n25), .B(n24), .Q(Data_out[7]) );
  NAND2XL U85 ( .A(n27), .B(n26), .Q(Data_out[8]) );
  NAND2XL U86 ( .A(n29), .B(n28), .Q(Data_out[9]) );
  NAND2XL U87 ( .A(n31), .B(n30), .Q(Data_out[10]) );
  NAND2XL U88 ( .A(n33), .B(n32), .Q(Data_out[11]) );
  NAND2XL U89 ( .A(n35), .B(n34), .Q(Data_out[12]) );
  NAND2XL U90 ( .A(n37), .B(n36), .Q(Data_out[13]) );
  NAND2XL U91 ( .A(n39), .B(n38), .Q(Data_out[14]) );
  NAND2XL U92 ( .A(n44), .B(n43), .Q(Data_out[15]) );
  NAND2XL U93 ( .A(n46), .B(n45), .Q(Data_out[16]) );
  NAND2XL U94 ( .A(n48), .B(n47), .Q(Data_out[17]) );
  NAND2XL U95 ( .A(n50), .B(n49), .Q(Data_out[18]) );
  NAND2XL U96 ( .A(n52), .B(n51), .Q(Data_out[19]) );
  NAND2XL U97 ( .A(n54), .B(n53), .Q(Data_out[20]) );
  NAND2XL U98 ( .A(n56), .B(n55), .Q(Data_out[21]) );
  NAND2XL U99 ( .A(n58), .B(n57), .Q(Data_out[22]) );
  NAND2XL U100 ( .A(n60), .B(n59), .Q(Data_out[23]) );
  NAND2XL U101 ( .A(n62), .B(n61), .Q(Data_out[24]) );
  NAND2XL U102 ( .A(n64), .B(n63), .Q(Data_out[25]) );
  NAND2XL U103 ( .A(n66), .B(n65), .Q(Data_out[26]) );
  NAND2XL U104 ( .A(n68), .B(n67), .Q(Data_out[27]) );
  NAND2XL U105 ( .A(n70), .B(n69), .Q(Data_out[28]) );
  NAND2XL U106 ( .A(n72), .B(n71), .Q(Data_out[29]) );
  AOI22X1 U107 ( .A1(n2), .A2(Local_in[30]), .B1(n76), .B2(West_in[30]), .Q(
        n74) );
  NAND2XL U108 ( .A(n75), .B(n74), .Q(Data_out[30]) );
  AOI22X1 U109 ( .A1(n2), .A2(Local_in[31]), .B1(n76), .B2(West_in[31]), .Q(
        n77) );
  NAND2XL U110 ( .A(n78), .B(n77), .Q(Data_out[31]) );
endmodule


module XBAR_DATA_WIDTH32_0 ( North_in, East_in, West_in, South_in, Local_in, 
        sel, Data_out );
  input [31:0] North_in;
  input [31:0] East_in;
  input [31:0] West_in;
  input [31:0] South_in;
  input [31:0] Local_in;
  input [4:0] sel;
  output [31:0] Data_out;
  wire   N22, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76;
  assign N22 = sel[1];

  NOR4X6 U1 ( .A(sel[3]), .B(sel[4]), .C(sel[2]), .D(n6), .Q(n74) );
  INVXL U2 ( .A(n2), .Q(n5) );
  AOI22X1 U3 ( .A1(n38), .A2(East_in[1]), .B1(North_in[1]), .B2(n72), .Q(n11)
         );
  AOI22X1 U4 ( .A1(n38), .A2(East_in[2]), .B1(North_in[2]), .B2(n72), .Q(n13)
         );
  AOI22X1 U5 ( .A1(n38), .A2(East_in[3]), .B1(North_in[3]), .B2(n72), .Q(n15)
         );
  AOI22X1 U6 ( .A1(n38), .A2(East_in[4]), .B1(North_in[4]), .B2(n72), .Q(n17)
         );
  AOI22X1 U7 ( .A1(n38), .A2(East_in[6]), .B1(North_in[6]), .B2(n72), .Q(n21)
         );
  AOI22X1 U8 ( .A1(n38), .A2(East_in[7]), .B1(North_in[7]), .B2(n72), .Q(n23)
         );
  AOI22X1 U9 ( .A1(n38), .A2(East_in[8]), .B1(North_in[8]), .B2(n72), .Q(n25)
         );
  AOI22X1 U10 ( .A1(n38), .A2(East_in[9]), .B1(North_in[9]), .B2(n72), .Q(n27)
         );
  AOI22X1 U11 ( .A1(n38), .A2(East_in[10]), .B1(North_in[10]), .B2(n72), .Q(
        n29) );
  AOI22X1 U12 ( .A1(n38), .A2(East_in[11]), .B1(North_in[11]), .B2(n72), .Q(
        n31) );
  AOI22X1 U13 ( .A1(n74), .A2(South_in[11]), .B1(n69), .B2(West_in[11]), .Q(
        n30) );
  AOI22X1 U14 ( .A1(n38), .A2(East_in[12]), .B1(North_in[12]), .B2(n72), .Q(
        n33) );
  AOI22X1 U15 ( .A1(n38), .A2(East_in[14]), .B1(North_in[14]), .B2(n72), .Q(
        n37) );
  AOI22X1 U16 ( .A1(n74), .A2(South_in[17]), .B1(n69), .B2(West_in[17]), .Q(
        n43) );
  AOI22X1 U17 ( .A1(n74), .A2(South_in[18]), .B1(n69), .B2(West_in[18]), .Q(
        n45) );
  AOI22X1 U18 ( .A1(n74), .A2(South_in[19]), .B1(n69), .B2(West_in[19]), .Q(
        n47) );
  AOI22X1 U19 ( .A1(n74), .A2(South_in[20]), .B1(n69), .B2(West_in[20]), .Q(
        n49) );
  AOI22X1 U20 ( .A1(n74), .A2(South_in[22]), .B1(n69), .B2(West_in[22]), .Q(
        n53) );
  AOI22X1 U21 ( .A1(n74), .A2(South_in[23]), .B1(n69), .B2(West_in[23]), .Q(
        n55) );
  AOI22X1 U22 ( .A1(n74), .A2(South_in[24]), .B1(n69), .B2(West_in[24]), .Q(
        n57) );
  AOI22X1 U23 ( .A1(n74), .A2(South_in[25]), .B1(n69), .B2(West_in[25]), .Q(
        n59) );
  AOI22X1 U24 ( .A1(n74), .A2(South_in[26]), .B1(n69), .B2(West_in[26]), .Q(
        n61) );
  AOI22X1 U25 ( .A1(n74), .A2(South_in[27]), .B1(n69), .B2(West_in[27]), .Q(
        n63) );
  AOI22X1 U26 ( .A1(n74), .A2(South_in[29]), .B1(n69), .B2(West_in[29]), .Q(
        n67) );
  AOI22X1 U27 ( .A1(n38), .A2(East_in[30]), .B1(North_in[30]), .B2(n72), .Q(
        n71) );
  AOI22X1 U28 ( .A1(n74), .A2(South_in[15]), .B1(n69), .B2(West_in[15]), .Q(
        n39) );
  AOI22X1 U29 ( .A1(n74), .A2(South_in[16]), .B1(n69), .B2(West_in[16]), .Q(
        n41) );
  NOR2XL U30 ( .A(sel[2]), .B(N22), .Q(n2) );
  AOI21X1 U31 ( .A1(sel[2]), .A2(N22), .B1(sel[4]), .Q(n3) );
  CLKBUFX2 U32 ( .A(n73), .Q(n69) );
  AOI22X1 U33 ( .A1(n38), .A2(East_in[0]), .B1(North_in[0]), .B2(n72), .Q(n9)
         );
  AOI22X1 U34 ( .A1(n38), .A2(East_in[5]), .B1(North_in[5]), .B2(n72), .Q(n19)
         );
  AOI22X1 U35 ( .A1(n38), .A2(East_in[13]), .B1(North_in[13]), .B2(n72), .Q(
        n35) );
  AOI22X1 U36 ( .A1(n74), .A2(South_in[21]), .B1(n69), .B2(West_in[21]), .Q(
        n51) );
  AOI22X1 U37 ( .A1(n74), .A2(South_in[28]), .B1(n69), .B2(West_in[28]), .Q(
        n65) );
  NAND2XL U38 ( .A(sel[3]), .B(n2), .Q(n1) );
  NOR2X3 U39 ( .A(sel[4]), .B(n1), .Q(n38) );
  NAND2XL U40 ( .A(n5), .B(sel[3]), .Q(n4) );
  OAI211X3 U41 ( .A1(n5), .A2(sel[3]), .B1(n4), .C1(n3), .Q(n72) );
  INVXL U42 ( .A(N22), .Q(n6) );
  INVXL U43 ( .A(sel[2]), .Q(n7) );
  NOR4X3 U44 ( .A(sel[3]), .B(sel[4]), .C(N22), .D(n7), .Q(n73) );
  AOI22X1 U45 ( .A1(n74), .A2(South_in[0]), .B1(n73), .B2(West_in[0]), .Q(n8)
         );
  NAND2XL U46 ( .A(n9), .B(n8), .Q(Data_out[0]) );
  AOI22X1 U47 ( .A1(n74), .A2(South_in[1]), .B1(n73), .B2(West_in[1]), .Q(n10)
         );
  NAND2XL U48 ( .A(n11), .B(n10), .Q(Data_out[1]) );
  AOI22X1 U49 ( .A1(n74), .A2(South_in[2]), .B1(n73), .B2(West_in[2]), .Q(n12)
         );
  NAND2XL U50 ( .A(n13), .B(n12), .Q(Data_out[2]) );
  AOI22X1 U51 ( .A1(n74), .A2(South_in[3]), .B1(n73), .B2(West_in[3]), .Q(n14)
         );
  NAND2XL U52 ( .A(n15), .B(n14), .Q(Data_out[3]) );
  AOI22X1 U53 ( .A1(n74), .A2(South_in[4]), .B1(n73), .B2(West_in[4]), .Q(n16)
         );
  NAND2XL U54 ( .A(n17), .B(n16), .Q(Data_out[4]) );
  AOI22X1 U55 ( .A1(n74), .A2(South_in[5]), .B1(n73), .B2(West_in[5]), .Q(n18)
         );
  NAND2XL U56 ( .A(n19), .B(n18), .Q(Data_out[5]) );
  AOI22X1 U57 ( .A1(n74), .A2(South_in[6]), .B1(n73), .B2(West_in[6]), .Q(n20)
         );
  NAND2XL U58 ( .A(n21), .B(n20), .Q(Data_out[6]) );
  AOI22X1 U59 ( .A1(n74), .A2(South_in[7]), .B1(n73), .B2(West_in[7]), .Q(n22)
         );
  NAND2XL U60 ( .A(n23), .B(n22), .Q(Data_out[7]) );
  AOI22X1 U61 ( .A1(n74), .A2(South_in[8]), .B1(n73), .B2(West_in[8]), .Q(n24)
         );
  NAND2XL U62 ( .A(n25), .B(n24), .Q(Data_out[8]) );
  AOI22X1 U63 ( .A1(n74), .A2(South_in[9]), .B1(n73), .B2(West_in[9]), .Q(n26)
         );
  NAND2XL U64 ( .A(n27), .B(n26), .Q(Data_out[9]) );
  AOI22X1 U65 ( .A1(n74), .A2(South_in[10]), .B1(n69), .B2(West_in[10]), .Q(
        n28) );
  NAND2XL U66 ( .A(n29), .B(n28), .Q(Data_out[10]) );
  NAND2XL U67 ( .A(n31), .B(n30), .Q(Data_out[11]) );
  AOI22X1 U68 ( .A1(n74), .A2(South_in[12]), .B1(n73), .B2(West_in[12]), .Q(
        n32) );
  NAND2XL U69 ( .A(n33), .B(n32), .Q(Data_out[12]) );
  AOI22X1 U70 ( .A1(n74), .A2(South_in[13]), .B1(n73), .B2(West_in[13]), .Q(
        n34) );
  NAND2XL U71 ( .A(n35), .B(n34), .Q(Data_out[13]) );
  AOI22X1 U72 ( .A1(n74), .A2(South_in[14]), .B1(n73), .B2(West_in[14]), .Q(
        n36) );
  NAND2XL U73 ( .A(n37), .B(n36), .Q(Data_out[14]) );
  AOI22X1 U74 ( .A1(n38), .A2(East_in[15]), .B1(North_in[15]), .B2(n72), .Q(
        n40) );
  NAND2XL U75 ( .A(n40), .B(n39), .Q(Data_out[15]) );
  AOI22X1 U76 ( .A1(n38), .A2(East_in[16]), .B1(North_in[16]), .B2(n72), .Q(
        n42) );
  NAND2XL U77 ( .A(n42), .B(n41), .Q(Data_out[16]) );
  AOI22X1 U78 ( .A1(n38), .A2(East_in[17]), .B1(North_in[17]), .B2(n72), .Q(
        n44) );
  NAND2XL U79 ( .A(n44), .B(n43), .Q(Data_out[17]) );
  AOI22X1 U80 ( .A1(n38), .A2(East_in[18]), .B1(North_in[18]), .B2(n72), .Q(
        n46) );
  NAND2XL U81 ( .A(n46), .B(n45), .Q(Data_out[18]) );
  AOI22X1 U82 ( .A1(n38), .A2(East_in[19]), .B1(North_in[19]), .B2(n72), .Q(
        n48) );
  NAND2XL U83 ( .A(n48), .B(n47), .Q(Data_out[19]) );
  AOI22X1 U84 ( .A1(n38), .A2(East_in[20]), .B1(North_in[20]), .B2(n72), .Q(
        n50) );
  NAND2XL U85 ( .A(n50), .B(n49), .Q(Data_out[20]) );
  AOI22X1 U86 ( .A1(n38), .A2(East_in[21]), .B1(North_in[21]), .B2(n72), .Q(
        n52) );
  NAND2XL U87 ( .A(n52), .B(n51), .Q(Data_out[21]) );
  AOI22X1 U88 ( .A1(n38), .A2(East_in[22]), .B1(North_in[22]), .B2(n72), .Q(
        n54) );
  NAND2XL U89 ( .A(n54), .B(n53), .Q(Data_out[22]) );
  AOI22X1 U90 ( .A1(n38), .A2(East_in[23]), .B1(North_in[23]), .B2(n72), .Q(
        n56) );
  NAND2XL U91 ( .A(n56), .B(n55), .Q(Data_out[23]) );
  AOI22X1 U92 ( .A1(n38), .A2(East_in[24]), .B1(North_in[24]), .B2(n72), .Q(
        n58) );
  NAND2XL U93 ( .A(n58), .B(n57), .Q(Data_out[24]) );
  AOI22X1 U94 ( .A1(n38), .A2(East_in[25]), .B1(North_in[25]), .B2(n72), .Q(
        n60) );
  NAND2XL U95 ( .A(n60), .B(n59), .Q(Data_out[25]) );
  AOI22X1 U96 ( .A1(n38), .A2(East_in[26]), .B1(North_in[26]), .B2(n72), .Q(
        n62) );
  NAND2XL U97 ( .A(n62), .B(n61), .Q(Data_out[26]) );
  AOI22X1 U98 ( .A1(n38), .A2(East_in[27]), .B1(North_in[27]), .B2(n72), .Q(
        n64) );
  NAND2XL U99 ( .A(n64), .B(n63), .Q(Data_out[27]) );
  AOI22X1 U100 ( .A1(n38), .A2(East_in[28]), .B1(North_in[28]), .B2(n72), .Q(
        n66) );
  NAND2XL U101 ( .A(n66), .B(n65), .Q(Data_out[28]) );
  AOI22X1 U102 ( .A1(n38), .A2(East_in[29]), .B1(North_in[29]), .B2(n72), .Q(
        n68) );
  NAND2XL U103 ( .A(n68), .B(n67), .Q(Data_out[29]) );
  AOI22X1 U104 ( .A1(n74), .A2(South_in[30]), .B1(n69), .B2(West_in[30]), .Q(
        n70) );
  NAND2XL U105 ( .A(n71), .B(n70), .Q(Data_out[30]) );
  AOI22X1 U106 ( .A1(n38), .A2(East_in[31]), .B1(North_in[31]), .B2(n72), .Q(
        n76) );
  AOI22X1 U107 ( .A1(n74), .A2(South_in[31]), .B1(n73), .B2(West_in[31]), .Q(
        n75) );
  NAND2XL U108 ( .A(n76), .B(n75), .Q(Data_out[31]) );
endmodule


module router_credit_based_DATA_WIDTH32_current_address5_Cx_rst15_NoC_size4 ( 
        reset, clk, Rxy_reconf, Reconfig, RX_N, RX_E, RX_W, RX_S, RX_L, 
        credit_in_N, credit_in_E, credit_in_W, credit_in_S, credit_in_L, 
        valid_in_N, valid_in_E, valid_in_W, valid_in_S, valid_in_L, 
        valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L, 
        credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L, 
        TX_N, TX_E, TX_W, TX_S, TX_L );
  input [7:0] Rxy_reconf;
  input [31:0] RX_N;
  input [31:0] RX_E;
  input [31:0] RX_W;
  input [31:0] RX_S;
  input [31:0] RX_L;
  output [31:0] TX_N;
  output [31:0] TX_E;
  output [31:0] TX_W;
  output [31:0] TX_S;
  output [31:0] TX_L;
  input reset, clk, Reconfig, credit_in_N, credit_in_E, credit_in_W,
         credit_in_S, credit_in_L, valid_in_N, valid_in_E, valid_in_W,
         valid_in_S, valid_in_L;
  output valid_out_N, valid_out_E, valid_out_W, valid_out_S, valid_out_L,
         credit_out_N, credit_out_E, credit_out_W, credit_out_S, credit_out_L;
  wire   net2279, empty_N, empty_E, empty_W, empty_S, empty_L, Req_NE, Req_NW,
         Req_NS, Req_NL, Req_EN, Req_EW, Req_ES, Req_EL, Req_WN, Req_WE,
         Req_WS, Req_WL, Req_SN, Req_SE, Req_SW, Req_SL, Req_LN, Req_LE,
         Req_LW, Req_LS, Xbar_sel_E_4, Xbar_sel_W_1, Xbar_sel_W_0,
         Xbar_sel_S_0;
  wire   [31:0] FIFO_D_out_N;
  wire   [31:0] FIFO_D_out_E;
  wire   [31:0] FIFO_D_out_W;
  wire   [31:0] FIFO_D_out_S;
  wire   [31:0] FIFO_D_out_L;
  wire   [3:0] Xbar_sel_N;
  wire   [2:0] Xbar_sel_E;
  wire   [4:3] Xbar_sel_W;
  wire   [4:2] Xbar_sel_S;
  wire   [4:1] Xbar_sel_L;

  FIFO_credit_based_DATA_WIDTH32_4 FIFO_N ( .reset(reset), .clk(clk), .RX(RX_N), .valid_in(valid_in_N), .read_en_N(net2279), .read_en_E(Xbar_sel_E_4), 
        .read_en_W(Xbar_sel_W[4]), .read_en_S(Xbar_sel_S[4]), .read_en_L(
        Xbar_sel_L[4]), .credit_out(credit_out_N), .empty_out(empty_N), 
        .Data_out(FIFO_D_out_N) );
  FIFO_credit_based_DATA_WIDTH32_3 FIFO_E ( .reset(reset), .clk(clk), .RX(RX_E), .valid_in(valid_in_E), .read_en_N(Xbar_sel_N[3]), .read_en_E(net2279), 
        .read_en_W(Xbar_sel_W[3]), .read_en_S(Xbar_sel_S[3]), .read_en_L(
        Xbar_sel_L[3]), .credit_out(credit_out_E), .empty_out(empty_E), 
        .Data_out(FIFO_D_out_E) );
  FIFO_credit_based_DATA_WIDTH32_2 FIFO_W ( .reset(reset), .clk(clk), .RX(RX_W), .valid_in(valid_in_W), .read_en_N(Xbar_sel_N[2]), .read_en_E(Xbar_sel_E[2]), 
        .read_en_W(net2279), .read_en_S(Xbar_sel_S[2]), .read_en_L(
        Xbar_sel_L[2]), .credit_out(credit_out_W), .empty_out(empty_W), 
        .Data_out(FIFO_D_out_W) );
  FIFO_credit_based_DATA_WIDTH32_1 FIFO_S ( .reset(reset), .clk(clk), .RX(RX_S), .valid_in(valid_in_S), .read_en_N(Xbar_sel_N[1]), .read_en_E(Xbar_sel_E[1]), 
        .read_en_W(Xbar_sel_W_1), .read_en_S(net2279), .read_en_L(
        Xbar_sel_L[1]), .credit_out(credit_out_S), .empty_out(empty_S), 
        .Data_out(FIFO_D_out_S) );
  FIFO_credit_based_DATA_WIDTH32_0 FIFO_L ( .reset(reset), .clk(clk), .RX(RX_L), .valid_in(valid_in_L), .read_en_N(Xbar_sel_N[0]), .read_en_E(Xbar_sel_E[0]), 
        .read_en_W(Xbar_sel_W_0), .read_en_S(Xbar_sel_S_0), .read_en_L(net2279), .credit_out(credit_out_L), .empty_out(empty_L), .Data_out(FIFO_D_out_L) );
  LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_4 LBDR_N ( .reset(reset), .clk(clk), 
        .Rxy_reconf({Rxy_reconf[7:2], net2279, net2279}), .Reconfig(Reconfig), 
        .empty(empty_N), .flit_type(FIFO_D_out_N[31:29]), .dst_addr(
        FIFO_D_out_N[16:13]), .grant_N(net2279), .grant_E(Xbar_sel_E_4), 
        .grant_W(Xbar_sel_W[4]), .grant_S(Xbar_sel_S[4]), .grant_L(
        Xbar_sel_L[4]), .Req_E(Req_NE), .Req_W(Req_NW), .Req_S(Req_NS), 
        .Req_L(Req_NL) );
  LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_3 LBDR_E ( .reset(reset), .clk(clk), 
        .Rxy_reconf({Rxy_reconf[7:4], net2279, net2279, Rxy_reconf[1:0]}), 
        .Reconfig(Reconfig), .empty(empty_E), .flit_type(FIFO_D_out_E[31:29]), 
        .dst_addr(FIFO_D_out_E[16:13]), .grant_N(Xbar_sel_N[3]), .grant_E(
        net2279), .grant_W(Xbar_sel_W[3]), .grant_S(Xbar_sel_S[3]), .grant_L(
        Xbar_sel_L[3]), .Req_N(Req_EN), .Req_W(Req_EW), .Req_L(Req_EL), 
        .Req_S_BAR(Req_ES) );
  LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_2 LBDR_W ( .reset(reset), .clk(clk), 
        .Rxy_reconf({Rxy_reconf[7:6], net2279, net2279, Rxy_reconf[3:0]}), 
        .Reconfig(Reconfig), .empty(empty_W), .flit_type(FIFO_D_out_W[31:29]), 
        .dst_addr(FIFO_D_out_W[16:13]), .grant_N(Xbar_sel_N[2]), .grant_E(
        Xbar_sel_E[2]), .grant_W(net2279), .grant_S(Xbar_sel_S[2]), .grant_L(
        Xbar_sel_L[2]), .Req_N(Req_WN), .Req_E(Req_WE), .Req_L(Req_WL), 
        .Req_S_BAR(Req_WS) );
  LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_1 LBDR_S ( .reset(reset), .clk(clk), 
        .Rxy_reconf({net2279, net2279, Rxy_reconf[5:0]}), .Reconfig(Reconfig), 
        .empty(empty_S), .flit_type(FIFO_D_out_S[31:29]), .dst_addr(
        FIFO_D_out_S[16:13]), .grant_N(Xbar_sel_N[1]), .grant_E(Xbar_sel_E[1]), 
        .grant_W(Xbar_sel_W_1), .grant_S(net2279), .grant_L(Xbar_sel_L[1]), 
        .Req_N(Req_SN), .Req_E(Req_SE), .Req_W(Req_SW), .Req_L(Req_SL) );
  LBDR_cur_addr_rst5_Cx_rst15_NoC_size4_0 LBDR_L ( .reset(reset), .clk(clk), 
        .Rxy_reconf(Rxy_reconf), .Reconfig(Reconfig), .empty(empty_L), 
        .flit_type(FIFO_D_out_L[31:29]), .dst_addr(FIFO_D_out_L[16:13]), 
        .grant_N(Xbar_sel_N[0]), .grant_E(Xbar_sel_E[0]), .grant_W(
        Xbar_sel_W_0), .grant_S(Xbar_sel_S_0), .grant_L(net2279), .Req_N(
        Req_LN), .Req_E(Req_LE), .Req_W(Req_LW), .Req_S(Req_LS) );
  allocator allocator_unit ( .reset(reset), .clk(clk), .credit_in_N(
        credit_in_N), .credit_in_E(credit_in_E), .credit_in_W(credit_in_W), 
        .credit_in_S(credit_in_S), .credit_in_L(credit_in_L), .req_N_N(net2279), .req_N_E(Req_NE), .req_N_W(Req_NW), .req_N_S(Req_NS), .req_N_L(Req_NL), 
        .req_E_N(Req_EN), .req_E_E(net2279), .req_E_W(Req_EW), .req_E_L(Req_EL), .req_W_N(Req_WN), .req_W_E(Req_WE), .req_W_W(net2279), .req_W_L(Req_WL), 
        .req_S_N(Req_SN), .req_S_E(Req_SE), .req_S_W(Req_SW), .req_S_S(net2279), .req_S_L(Req_SL), .req_L_N(Req_LN), .req_L_E(Req_LE), .req_L_W(Req_LW), 
        .req_L_S(Req_LS), .req_L_L(net2279), .empty_N(empty_N), .empty_E(
        empty_E), .empty_W(empty_W), .empty_S(empty_S), .empty_L(empty_L), 
        .valid_N(valid_out_N), .valid_E(valid_out_E), .valid_W(valid_out_W), 
        .valid_S(valid_out_S), .valid_L(valid_out_L), .grant_N_E(Xbar_sel_N[3]), .grant_N_W(Xbar_sel_N[2]), .grant_N_S(Xbar_sel_N[1]), .grant_N_L(
        Xbar_sel_N[0]), .grant_E_N(Xbar_sel_E_4), .grant_E_W(Xbar_sel_E[2]), 
        .grant_E_S(Xbar_sel_E[1]), .grant_E_L(Xbar_sel_E[0]), .grant_W_N(
        Xbar_sel_W[4]), .grant_W_E(Xbar_sel_W[3]), .grant_W_S(Xbar_sel_W_1), 
        .grant_W_L(Xbar_sel_W_0), .grant_S_N(Xbar_sel_S[4]), .grant_S_E(
        Xbar_sel_S[3]), .grant_S_W(Xbar_sel_S[2]), .grant_S_L(Xbar_sel_S_0), 
        .grant_L_N(Xbar_sel_L[4]), .grant_L_E(Xbar_sel_L[3]), .grant_L_W(
        Xbar_sel_L[2]), .grant_L_S(Xbar_sel_L[1]), .req_W_S_BAR(Req_WS), 
        .req_E_S_BAR(Req_ES) );
  XBAR_DATA_WIDTH32_4 XBAR_N ( .North_in(FIFO_D_out_N), .East_in(FIFO_D_out_E), 
        .West_in(FIFO_D_out_W), .South_in(FIFO_D_out_S), .Local_in(
        FIFO_D_out_L), .sel({net2279, Xbar_sel_N}), .Data_out(TX_N) );
  XBAR_DATA_WIDTH32_3 XBAR_E ( .North_in(FIFO_D_out_N), .East_in({net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279}), 
        .West_in(FIFO_D_out_W), .South_in(FIFO_D_out_S), .Local_in(
        FIFO_D_out_L), .sel({Xbar_sel_E_4, net2279, Xbar_sel_E}), .Data_out(
        TX_E) );
  XBAR_DATA_WIDTH32_2 XBAR_W ( .North_in(FIFO_D_out_N), .East_in(FIFO_D_out_E), 
        .West_in({net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279}), .South_in(FIFO_D_out_S), .Local_in(FIFO_D_out_L), 
        .sel({Xbar_sel_W, net2279, Xbar_sel_W_1, Xbar_sel_W_0}), .Data_out(
        TX_W) );
  XBAR_DATA_WIDTH32_1 XBAR_S ( .North_in(FIFO_D_out_N), .East_in(FIFO_D_out_E), 
        .West_in(FIFO_D_out_W), .South_in({net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279}), .Local_in(FIFO_D_out_L), .sel({
        Xbar_sel_S, net2279, Xbar_sel_S_0}), .Data_out(TX_S) );
  XBAR_DATA_WIDTH32_0 XBAR_L ( .North_in(FIFO_D_out_N), .East_in(FIFO_D_out_E), 
        .West_in(FIFO_D_out_W), .South_in(FIFO_D_out_S), .Local_in({net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279, net2279, 
        net2279, net2279, net2279, net2279, net2279, net2279, net2279}), .sel(
        {Xbar_sel_L, net2279}), .Data_out(TX_L) );
  LOGIC0 U11 ( .Q(net2279) );
endmodule

