/* Nangate 45nm  */

module AND2_X1(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
  endspecify
endmodule

module AND2_X2(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
  endspecify
endmodule

module AND2_X4(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.06;
    (A2 => ZN) = 0.06;
  endspecify
endmodule

module AND3_X1(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _0_ = _1_ & A3;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.15;
    (A2 => ZN) = 0.15;
    (A3 => ZN) = 0.12;
  endspecify
endmodule

module AND3_X2(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign _1_ = _0_ & A3;
  assign ZN = _1_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (A3 => ZN) = 0.1;
  endspecify
endmodule

module AND3_X4(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign _1_ = _0_ & A3;
  assign ZN = _1_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
  endspecify
endmodule

module AND4_X1(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign _1_ = _0_ & A3;
  assign _2_ = _1_ & A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.2;
    (A2 => ZN) = 0.2;
    (A3 => ZN) = 0.17;
    (A4 => ZN) = 0.15;
  endspecify
endmodule

module AND4_X2(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign _1_ = _0_ & A3;
  assign _2_ = _1_ & A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.17;
    (A2 => ZN) = 0.17;
    (A3 => ZN) = 0.14;
    (A4 => ZN) = 0.12;
  endspecify
endmodule

module AND4_X4(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 & A2;
  assign _1_ = _0_ & A3;
  assign _2_ = _1_ & A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (A3 => ZN) = 0.11;
    (A4 => ZN) = 0.1;
  endspecify
endmodule

module ANTENNA_X1(A);
  input A;
  wire A;
endmodule

module AOI211_X1(A, B, ZN, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = C1 & C2;
  assign _2_ = _1_ | B;
  assign _3_ = _2_ | A;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.12;
    (B => ZN) = 0.14;
    (C1 => ZN) = 0.16;
    (C2 => ZN) = 0.16;
  endspecify
endmodule

module AOI211_X2(A, B, ZN, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = C1 & C2;
  assign _2_ = _1_ | B;
  assign _3_ = _2_ | A;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.1;
    (B => ZN) = 0.12;
    (C1 => ZN) = 0.14;
    (C2 => ZN) = 0.14;
  endspecify
endmodule

module AOI211_X4(A, B, ZN, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _03_ = C1 & C2;
  assign _05_ = _03_ | B;
  assign _04_ = _05_ | A;
  assign _00_ = ~_04_;
  assign _01_ = ~_00_;
  assign _02_ = ~_01_;
  assign ZN = _02_;
  specify
    (A => ZN) = 0.08;
    (B => ZN) = 0.1;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module AOI21_X1(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = B1 & B2;
  assign _2_ = A | _1_;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.08;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
  endspecify
endmodule

module AOI21_X2(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = B1 & B2;
  assign _2_ = A | _1_;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.07;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
  endspecify
endmodule

module AOI21_X4(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = B1 & B2;
  assign _2_ = A | _1_;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.05;
    (B1 => ZN) = 0.08;
    (B2 => ZN) = 0.08;
  endspecify
endmodule

module AOI221_X1(A, ZN, B1, B2, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = C1 & C2;
  assign _2_ = B1 & B2;
  assign _3_ = _1_ | A;
  assign _4_ = _3_ | _2_;
  assign _0_ = ~_4_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.1;
    (B1 => ZN) = 0.14;
    (B2 => ZN) = 0.14;
    (C1 => ZN) = 0.14;
    (C2 => ZN) = 0.14;
  endspecify
endmodule

module AOI221_X2(A, ZN, B1, B2, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = C1 & C2;
  assign _2_ = B1 & B2;
  assign _3_ = _1_ | A;
  assign _4_ = _3_ | _2_;
  assign _0_ = ~_4_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.08;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module AOI221_X4(A, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _03_ = C1 & C2;
  assign _04_ = B1 & B2;
  assign _05_ = _03_ | A;
  assign _06_ = _05_ | _04_;
  assign _00_ = ~_06_;
  assign _01_ = ~_00_;
  assign _02_ = ~_01_;
  assign ZN = _02_;
  specify
    (A => ZN) = 0.06;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
    (C1 => ZN) = 0.1;
    (C2 => ZN) = 0.1;
  endspecify
endmodule

module AOI222_X1(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _01_ = A1 & A2;
  assign _02_ = B1 & B2;
  assign _03_ = C1 & C2;
  assign _04_ = _01_ | _02_;
  assign _05_ = _04_ | _03_;
  assign _00_ = ~_05_;
  assign ZN = _00_;
  specify
    (A1 => ZN) = 0.16;
    (A2 => ZN) = 0.16;
    (B1 => ZN) = 0.16;
    (B2 => ZN) = 0.16;
    (C1 => ZN) = 0.16;
    (C2 => ZN) = 0.16;
  endspecify
endmodule

module AOI222_X2(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _01_ = A1 & A2;
  assign _02_ = B1 & B2;
  assign _03_ = C1 & C2;
  assign _04_ = _01_ | _02_;
  assign _05_ = _04_ | _03_;
  assign _00_ = ~_05_;
  assign ZN = _00_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (B1 => ZN) = 0.14;
    (B2 => ZN) = 0.14;
    (C1 => ZN) = 0.14;
    (C2 => ZN) = 0.14;
  endspecify
endmodule

module AOI222_X4(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _03_ = A1 & A2;
  assign _04_ = B1 & B2;
  assign _05_ = C1 & C2;
  assign _06_ = _03_ | _04_;
  assign _07_ = _06_ | _05_;
  assign _00_ = ~_07_;
  assign _01_ = ~_00_;
  assign _02_ = ~_01_;
  assign ZN = _02_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module AOI22_X1(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = B1 & B2;
  assign _3_ = _1_ | _2_;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
  endspecify
endmodule

module AOI22_X2(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = B1 & B2;
  assign _3_ = _1_ | _2_;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
  endspecify
endmodule

module AOI22_X4(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = B1 & B2;
  assign _3_ = _1_ | _2_;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
    (B1 => ZN) = 0.08;
    (B2 => ZN) = 0.08;
  endspecify
endmodule

module BUF_X1(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.06;
  endspecify
endmodule

module BUF_X16(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.02;
  endspecify
endmodule

module BUF_X2(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.05;
  endspecify
endmodule

module BUF_X32(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.015;
  endspecify
endmodule

module BUF_X4(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.04;
  endspecify
endmodule

module BUF_X8(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.03;
  endspecify
endmodule

module CLKBUF_X1(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.08;
  endspecify
endmodule

module CLKBUF_X2(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.07;
  endspecify
endmodule

module CLKBUF_X3(A, Z);
  input A;
  wire A;
  output Z;
  wire Z;
  assign Z = A;
  specify
    (A => Z) = 0.06;
  endspecify
endmodule

module DFFRS_X1(D, Q, RN, SN, CK, QN);
  wire _0_;
  wire _1_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SN;
  wire SN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN, negedge RN)
    if (!RN) IQ <= 1'b0;
    else if (!SN) IQ <= 1'b1;
    else IQ <= D;
  assign _0_ = ~SN;
  assign _1_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.2, 0.15);
    (posedge CK => (QN : Q)) = (0.2, 0.15);
  endspecify
endmodule

module DFFRS_X2(D, Q, RN, SN, CK, QN);
  wire _0_;
  wire _1_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SN;
  wire SN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN, negedge RN)
    if (!RN) IQ <= 1'b0;
    else if (!SN) IQ <= 1'b1;
    else IQ <= D;
  assign _0_ = ~SN;
  assign _1_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.17, 0.13);
    (posedge CK => (QN : Q)) = (0.17, 0.13);
  endspecify
endmodule

module DFFR_X1(D, Q, RN, CK, QN);
  wire _0_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge RN)
    if (!RN) IQ <= 1'h0;
    else IQ <= D;
  assign _0_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.18, 0.14);
    (posedge CK => (QN : Q)) = (0.18, 0.14);
  endspecify
endmodule

module DFFR_X2(D, Q, RN, CK, QN);
  wire _0_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge RN)
    if (!RN) IQ <= 1'h0;
    else IQ <= D;
  assign _0_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.15, 0.12);
    (posedge CK => (QN : Q)) = (0.15, 0.12);
  endspecify
endmodule

module DFFS_X1(D, Q, SN, CK, QN);
  wire _0_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SN;
  wire SN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN)
    if (!SN) IQ <= 1'h1;
    else IQ <= D;
  assign _0_ = ~SN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.18, 0.14);
    (posedge CK => (QN : Q)) = (0.18, 0.14);
  endspecify
endmodule

module DFFS_X2(D, Q, SN, CK, QN);
  wire _0_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SN;
  wire SN;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN)
    if (!SN) IQ <= 1'h1;
    else IQ <= D;
  assign _0_ = ~SN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.15, 0.12);
    (posedge CK => (QN : Q)) = (0.15, 0.12);
  endspecify
endmodule

module DFF_X1(D, Q, CK, QN);
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  assign IQN = ~IQ;
  always @(posedge CK)
    IQ <= D;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.15, 0.12);
    (posedge CK => (QN : Q)) = (0.15, 0.12);
  endspecify
endmodule

module DFF_X2(D, Q, CK, QN);
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  assign IQN = ~IQ;
  always @(posedge CK)
    IQ <= D;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.12, 0.1);
    (posedge CK => (QN : Q)) = (0.12, 0.1);
  endspecify
endmodule

module DLH_X1(D, G, Q);
  input D;
  wire D;
  input G;
  wire G;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  assign IQN = ~IQ;
  always @*
    if (G) IQ = D;
  assign Q = IQ;
  specify
    (G => Q) = 0.12;
    (D => Q) = 0.08;
  endspecify
endmodule

module DLH_X2(D, G, Q);
  input D;
  wire D;
  input G;
  wire G;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  assign IQN = ~IQ;
  always @*
    if (G) IQ = D;
  assign Q = IQ;
  specify
    (G => Q) = 0.1;
    (D => Q) = 0.06;
  endspecify
endmodule

module DLL_X1(D, Q, GN);
  wire _0_;
  input D;
  wire D;
  input GN;
  wire GN;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  assign IQN = ~IQ;
  always @*
    if (!GN) IQ = D;
  assign _0_ = ~GN;
  assign Q = IQ;
  specify
    (GN => Q) = 0.14;
    (D => Q) = 0.08;
  endspecify
endmodule

module DLL_X2(D, Q, GN);
  wire _0_;
  input D;
  wire D;
  input GN;
  wire GN;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  assign IQN = ~IQ;
  always @*
    if (!GN) IQ = D;
  assign _0_ = ~GN;
  assign Q = IQ;
  specify
    (GN => Q) = 0.12;
    (D => Q) = 0.06;
  endspecify
endmodule

module FA_X1(A, B, CI, CO, S);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A;
  wire A;
  input B;
  wire B;
  input CI;
  wire CI;
  output CO;
  wire CO;
  output S;
  wire S;
  assign _00_ = A & B;
  assign _01_ = CI & _02_;
  assign _02_ = A | B;
  assign _03_ = _00_ | _01_;
  assign _04_ = A ^ B;
  assign _05_ = CI ^ _04_;
  assign CO = _03_;
  assign S = _05_;
  specify
    (A => CO) = 0.2;
    (B => CO) = 0.2;
    (CI => CO) = 0.18;
    (A => S) = 0.25;
    (B => S) = 0.25;
    (CI => S) = 0.2;
  endspecify
endmodule

module FILLCELL_X1();
endmodule

module FILLCELL_X16();
endmodule

module FILLCELL_X2();
endmodule

module FILLCELL_X32();
endmodule

module FILLCELL_X4();
endmodule

module FILLCELL_X8();
endmodule

module HA_X1(A, B, CO, S);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input B;
  wire B;
  output CO;
  wire CO;
  output S;
  wire S;
  assign _0_ = A & B;
  assign _1_ = A ^ B;
  assign CO = _0_;
  assign S = _1_;
  specify
    (A => CO) = 0.15;
    (B => CO) = 0.15;
    (A => S) = 0.18;
    (B => S) = 0.18;
  endspecify
endmodule

module INV_X1(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.04;
  endspecify
endmodule

module INV_X16(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.015;
  endspecify
endmodule

module INV_X2(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.035;
  endspecify
endmodule

module INV_X32(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.01;
  endspecify
endmodule

module INV_X4(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.025;
  endspecify
endmodule

module INV_X8(A, ZN);
  wire _0_;
  input A;
  wire A;
  output ZN;
  wire ZN;
  assign _0_ = ~A;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.02;
  endspecify
endmodule

module LOGIC0_X1(Z);
  output Z;
  wire Z;
  assign Z = 1'h0;
endmodule

module LOGIC1_X1(Z);
  output Z;
  wire Z;
  assign Z = 1'h1;
endmodule

module MUX2_X1(A, B, S, Z);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input S;
  wire S;
  output Z;
  wire Z;
  assign _1_ = S & B;
  assign _2_ = A & _0_;
  assign _3_ = _1_ | _2_;
  assign _0_ = ~S;
  assign Z = _3_;
  specify
    (A => Z) = 0.12;
    (B => Z) = 0.12;
    (S => Z) = 0.15;
  endspecify
endmodule

module MUX2_X2(A, B, S, Z);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input S;
  wire S;
  output Z;
  wire Z;
  assign _1_ = S & B;
  assign _2_ = A & _0_;
  assign _3_ = _1_ | _2_;
  assign _0_ = ~S;
  assign Z = _3_;
  specify
    (A => Z) = 0.1;
    (B => Z) = 0.1;
    (S => Z) = 0.12;
  endspecify
endmodule

module NAND2_X1(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.06;
    (A2 => ZN) = 0.06;
  endspecify
endmodule

module NAND2_X2(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.05;
    (A2 => ZN) = 0.05;
  endspecify
endmodule

module NAND2_X4(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.04;
    (A2 => ZN) = 0.04;
  endspecify
endmodule

module NAND3_X1(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
  endspecify
endmodule

module NAND3_X2(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
    (A3 => ZN) = 0.07;
  endspecify
endmodule

module NAND3_X4(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.07;
    (A2 => ZN) = 0.07;
    (A3 => ZN) = 0.06;
  endspecify
endmodule

module NAND4_X1(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _3_ = _2_ & A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (A3 => ZN) = 0.12;
    (A4 => ZN) = 0.1;
  endspecify
endmodule

module NAND4_X2(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _3_ = _2_ & A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (A3 => ZN) = 0.1;
    (A4 => ZN) = 0.08;
  endspecify
endmodule

module NAND4_X4(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 & A2;
  assign _2_ = _1_ & A3;
  assign _3_ = _2_ & A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
    (A4 => ZN) = 0.07;
  endspecify
endmodule

module NOR2_X1(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.06;
    (A2 => ZN) = 0.06;
  endspecify
endmodule

module NOR2_X2(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.05;
    (A2 => ZN) = 0.05;
  endspecify
endmodule

module NOR2_X4(A1, A2, ZN);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.04;
    (A2 => ZN) = 0.04;
  endspecify
endmodule

module NOR3_X1(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
  endspecify
endmodule

module NOR3_X2(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
    (A3 => ZN) = 0.07;
  endspecify
endmodule

module NOR3_X4(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.07;
    (A2 => ZN) = 0.07;
    (A3 => ZN) = 0.06;
  endspecify
endmodule

module NOR4_X1(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _3_ = _2_ | A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (A3 => ZN) = 0.12;
    (A4 => ZN) = 0.1;
  endspecify
endmodule

module NOR4_X2(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _3_ = _2_ | A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (A3 => ZN) = 0.1;
    (A4 => ZN) = 0.08;
  endspecify
endmodule

module NOR4_X4(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _1_ = A1 | A2;
  assign _2_ = _1_ | A3;
  assign _3_ = _2_ | A4;
  assign _0_ = ~_3_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
    (A4 => ZN) = 0.07;
  endspecify
endmodule

module OAI211_X1(A, B, ZN, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = _3_ & A;
  assign _2_ = _1_ & B;
  assign _3_ = C1 | C2;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.12;
    (B => ZN) = 0.12;
    (C1 => ZN) = 0.14;
    (C2 => ZN) = 0.14;
  endspecify
endmodule

module OAI211_X2(A, B, ZN, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = _3_ & A;
  assign _2_ = _1_ & B;
  assign _3_ = C1 | C2;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.1;
    (B => ZN) = 0.1;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module OAI211_X4(A, B, ZN, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A;
  wire A;
  input B;
  wire B;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = _3_ & A;
  assign _2_ = _1_ & B;
  assign _3_ = C1 | C2;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.08;
    (B => ZN) = 0.08;
    (C1 => ZN) = 0.1;
    (C2 => ZN) = 0.1;
  endspecify
endmodule

module OAI21_X1(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A & _2_;
  assign _2_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.08;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
  endspecify
endmodule

module OAI21_X2(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A & _2_;
  assign _2_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.07;
    (B1 => ZN) = 0.08;
    (B2 => ZN) = 0.08;
  endspecify
endmodule

module OAI21_X4(A, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = A & _2_;
  assign _2_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.05;
    (B1 => ZN) = 0.06;
    (B2 => ZN) = 0.06;
  endspecify
endmodule

module OAI221_X1(A, ZN, B1, B2, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = _3_ & A;
  assign _2_ = _1_ & _4_;
  assign _3_ = C1 | C2;
  assign _4_ = B1 | B2;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.1;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module OAI221_X2(A, ZN, B1, B2, C1, C2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  wire _4_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _1_ = _3_ & A;
  assign _2_ = _1_ & _4_;
  assign _3_ = C1 | C2;
  assign _4_ = B1 | B2;
  assign _0_ = ~_2_;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.08;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
    (C1 => ZN) = 0.1;
    (C2 => ZN) = 0.1;
  endspecify
endmodule

module OAI221_X4(A, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  input A;
  wire A;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _03_ = _05_ & A;
  assign _04_ = _03_ & _06_;
  assign _05_ = C1 | C2;
  assign _06_ = B1 | B2;
  assign _00_ = ~_04_;
  assign _01_ = ~_00_;
  assign _02_ = ~_01_;
  assign ZN = _02_;
  specify
    (A => ZN) = 0.06;
    (B1 => ZN) = 0.08;
    (B2 => ZN) = 0.08;
    (C1 => ZN) = 0.08;
    (C2 => ZN) = 0.08;
  endspecify
endmodule

module OAI222_X1(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _01_ = _03_ & _04_;
  assign _02_ = _01_ & _05_;
  assign _03_ = A1 | A2;
  assign _04_ = B1 | B2;
  assign _05_ = C1 | C2;
  assign _00_ = ~_02_;
  assign ZN = _00_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (B1 => ZN) = 0.14;
    (B2 => ZN) = 0.14;
    (C1 => ZN) = 0.14;
    (C2 => ZN) = 0.14;
  endspecify
endmodule

module OAI222_X2(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _01_ = _03_ & _04_;
  assign _02_ = _01_ & _05_;
  assign _03_ = A1 | A2;
  assign _04_ = B1 | B2;
  assign _05_ = C1 | C2;
  assign _00_ = ~_02_;
  assign ZN = _00_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (B1 => ZN) = 0.12;
    (B2 => ZN) = 0.12;
    (C1 => ZN) = 0.12;
    (C2 => ZN) = 0.12;
  endspecify
endmodule

module OAI222_X4(A1, A2, ZN, B1, B2, C1, C2);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input C1;
  wire C1;
  input C2;
  wire C2;
  output ZN;
  wire ZN;
  assign _03_ = _05_ & _06_;
  assign _04_ = _03_ & _07_;
  assign _05_ = A1 | A2;
  assign _06_ = B1 | B2;
  assign _07_ = C1 | C2;
  assign _00_ = ~_04_;
  assign _01_ = ~_00_;
  assign _02_ = ~_01_;
  assign ZN = _02_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
    (C1 => ZN) = 0.1;
    (C2 => ZN) = 0.1;
  endspecify
endmodule

module OAI22_X1(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = _2_ & _3_;
  assign _2_ = A1 | A2;
  assign _3_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (B1 => ZN) = 0.1;
    (B2 => ZN) = 0.1;
  endspecify
endmodule

module OAI22_X2(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = _2_ & _3_;
  assign _2_ = A1 | A2;
  assign _3_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
    (B1 => ZN) = 0.08;
    (B2 => ZN) = 0.08;
  endspecify
endmodule

module OAI22_X4(A1, A2, ZN, B1, B2);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input B1;
  wire B1;
  input B2;
  wire B2;
  output ZN;
  wire ZN;
  assign _1_ = _2_ & _3_;
  assign _2_ = A1 | A2;
  assign _3_ = B1 | B2;
  assign _0_ = ~_1_;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.06;
    (A2 => ZN) = 0.06;
    (B1 => ZN) = 0.06;
    (B2 => ZN) = 0.06;
  endspecify
endmodule

module OAI33_X1(A1, A2, ZN, A3, B1, B2, B3);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input B1;
  wire B1;
  input B2;
  wire B2;
  input B3;
  wire B3;
  output ZN;
  wire ZN;
  assign _01_ = _03_ & _05_;
  assign _02_ = A1 | A2;
  assign _03_ = _02_ | A3;
  assign _04_ = B1 | B2;
  assign _05_ = _04_ | B3;
  assign _00_ = ~_01_;
  assign ZN = _00_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (A3 => ZN) = 0.12;
    (B1 => ZN) = 0.14;
    (B2 => ZN) = 0.14;
    (B3 => ZN) = 0.12;
  endspecify
endmodule

module OR2_X1(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.06;
    (A2 => ZN) = 0.06;
  endspecify
endmodule

module OR2_X2(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.05;
    (A2 => ZN) = 0.05;
  endspecify
endmodule

module OR2_X4(A1, A2, ZN);
  wire _0_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign ZN = _0_;
  specify
    (A1 => ZN) = 0.04;
    (A2 => ZN) = 0.04;
  endspecify
endmodule

module OR3_X1(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign ZN = _1_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
  endspecify
endmodule

module OR3_X2(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign ZN = _1_;
  specify
    (A1 => ZN) = 0.08;
    (A2 => ZN) = 0.08;
    (A3 => ZN) = 0.07;
  endspecify
endmodule

module OR3_X4(A1, A2, ZN, A3);
  wire _0_;
  wire _1_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign ZN = _1_;
  specify
    (A1 => ZN) = 0.07;
    (A2 => ZN) = 0.07;
    (A3 => ZN) = 0.06;
  endspecify
endmodule

module OR4_X1(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign _2_ = _1_ | A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.14;
    (A2 => ZN) = 0.14;
    (A3 => ZN) = 0.12;
    (A4 => ZN) = 0.1;
  endspecify
endmodule

module OR4_X2(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign _2_ = _1_ | A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.12;
    (A2 => ZN) = 0.12;
    (A3 => ZN) = 0.1;
    (A4 => ZN) = 0.08;
  endspecify
endmodule

module OR4_X4(A1, A2, ZN, A3, A4);
  wire _0_;
  wire _1_;
  wire _2_;
  input A1;
  wire A1;
  input A2;
  wire A2;
  input A3;
  wire A3;
  input A4;
  wire A4;
  output ZN;
  wire ZN;
  assign _0_ = A1 | A2;
  assign _1_ = _0_ | A3;
  assign _2_ = _1_ | A4;
  assign ZN = _2_;
  specify
    (A1 => ZN) = 0.1;
    (A2 => ZN) = 0.1;
    (A3 => ZN) = 0.08;
    (A4 => ZN) = 0.07;
  endspecify
endmodule

module SDFFRS_X1(D, Q, RN, SN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  input SN;
  wire SN;
  assign _03_ = SE & SI;
  assign _04_ = D & _00_;
  assign _05_ = _03_ | _04_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN, negedge RN)
    if (!RN) IQ <= 1'b0;
    else if (!SN) IQ <= 1'b1;
    else IQ <= _05_;
  assign _00_ = ~SE;
  assign _01_ = ~SN;
  assign _02_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.22, 0.17);
    (posedge CK => (QN : Q)) = (0.22, 0.17);
  endspecify
endmodule

module SDFFRS_X2(D, Q, RN, SN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  input SN;
  wire SN;
  assign _03_ = SE & SI;
  assign _04_ = D & _00_;
  assign _05_ = _03_ | _04_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN, negedge RN)
    if (!RN) IQ <= 1'b0;
    else if (!SN) IQ <= 1'b1;
    else IQ <= _05_;
  assign _00_ = ~SE;
  assign _01_ = ~SN;
  assign _02_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.19, 0.15);
    (posedge CK => (QN : Q)) = (0.19, 0.15);
  endspecify
endmodule

module SDFFR_X1(D, Q, RN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  assign _02_ = SE & SI;
  assign _03_ = D & _00_;
  assign _04_ = _02_ | _03_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge RN)
    if (!RN) IQ <= 1'h0;
    else IQ <= _04_;
  assign _00_ = ~SE;
  assign _01_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.2, 0.16);
    (posedge CK => (QN : Q)) = (0.2, 0.16);
  endspecify
endmodule

module SDFFR_X2(D, Q, RN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input RN;
  wire RN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  assign _02_ = SE & SI;
  assign _03_ = D & _00_;
  assign _04_ = _02_ | _03_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge RN)
    if (!RN) IQ <= 1'h0;
    else IQ <= _04_;
  assign _00_ = ~SE;
  assign _01_ = ~RN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.17, 0.14);
    (posedge CK => (QN : Q)) = (0.17, 0.14);
  endspecify
endmodule

module SDFFS_X1(D, Q, SN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  input SN;
  wire SN;
  assign _02_ = SE & SI;
  assign _03_ = D & _00_;
  assign _04_ = _02_ | _03_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN)
    if (!SN) IQ <= 1'h1;
    else IQ <= _04_;
  assign _00_ = ~SE;
  assign _01_ = ~SN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.2, 0.16);
    (posedge CK => (QN : Q)) = (0.2, 0.16);
  endspecify
endmodule

module SDFFS_X2(D, Q, SN, CK, QN, SE, SI);
  wire _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  input SN;
  wire SN;
  assign _02_ = SE & SI;
  assign _03_ = D & _00_;
  assign _04_ = _02_ | _03_;
  assign IQN = ~IQ;
  always @(posedge CK, negedge SN)
    if (!SN) IQ <= 1'h1;
    else IQ <= _04_;
  assign _00_ = ~SE;
  assign _01_ = ~SN;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.17, 0.14);
    (posedge CK => (QN : Q)) = (0.17, 0.14);
  endspecify
endmodule

module SDFF_X1(D, Q, CK, QN, SE, SI);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  assign _1_ = SE & SI;
  assign _2_ = D & _0_;
  assign _3_ = _1_ | _2_;
  assign IQN = ~IQ;
  always @(posedge CK)
    IQ <= _3_;
  assign _0_ = ~SE;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.17, 0.14);
    (posedge CK => (QN : Q)) = (0.17, 0.14);
  endspecify
endmodule

module SDFF_X2(D, Q, CK, QN, SE, SI);
  wire _0_;
  wire _1_;
  wire _2_;
  wire _3_;
  input CK;
  wire CK;
  input D;
  wire D;
  reg IQ;
  wire IQN;
  output Q;
  wire Q;
  output QN;
  wire QN;
  input SE;
  wire SE;
  input SI;
  wire SI;
  assign _1_ = SE & SI;
  assign _2_ = D & _0_;
  assign _3_ = _1_ | _2_;
  assign IQN = ~IQ;
  always @(posedge CK)
    IQ <= _3_;
  assign _0_ = ~SE;
  assign Q = IQ;
  assign QN = IQN;
  specify
    (posedge CK => (Q : QN)) = (0.14, 0.12);
    (posedge CK => (QN : Q)) = (0.14, 0.12);
  endspecify
endmodule

module TAPCELL_X1();
endmodule

module TBUF_X1(A, EN, Z);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input EN;
  wire EN;
  output Z;
  wire Z;
  assign _0_ = _1_ ? A : 1'bz;
  assign _1_ = ~EN;
  assign Z = _0_;
  specify
    (A => Z) = 0.08;
    (EN => Z) = 0.1;
  endspecify
endmodule

module TBUF_X16(A, EN, Z);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input EN;
  wire EN;
  output Z;
  wire Z;
  assign _0_ = _1_ ? A : 1'bz;
  assign _1_ = ~EN;
  assign Z = _0_;
  specify
    (A => Z) = 0.03;
    (EN => Z) = 0.04;
  endspecify
endmodule

module TBUF_X2(A, EN, Z);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input EN;
  wire EN;
  output Z;
  wire Z;
  assign _0_ = _1_ ? A : 1'bz;
  assign _1_ = ~EN;
  assign Z = _0_;
  specify
    (A => Z) = 0.07;
    (EN => Z) = 0.08;
  endspecify
endmodule

module TBUF_X4(A, EN, Z);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input EN;
  wire EN;
  output Z;
  wire Z;
  assign _0_ = _1_ ? A : 1'bz;
  assign _1_ = ~EN;
  assign Z = _0_;
  specify
    (A => Z) = 0.05;
    (EN => Z) = 0.06;
  endspecify
endmodule

module TBUF_X8(A, EN, Z);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input EN;
  wire EN;
  output Z;
  wire Z;
  assign _0_ = _1_ ? A : 1'bz;
  assign _1_ = ~EN;
  assign Z = _0_;
  specify
    (A => Z) = 0.04;
    (EN => Z) = 0.05;
  endspecify
endmodule

module TINV_X1(EN, I, ZN);
  wire _0_;
  wire _1_;
  wire _2_;
  input EN;
  wire EN;
  input I;
  wire I;
  output ZN;
  wire ZN;
  assign _0_ = _2_ ? _1_ : 1'bz;
  assign _2_ = ~EN;
  assign _1_ = ~I;
  assign ZN = _0_;
  specify
    (I => ZN) = 0.08;
    (EN => ZN) = 0.1;
  endspecify
endmodule

module TLAT_X1(D, G, Q, OE);
  wire _0_;
  wire _1_;
  wire _2_;
  input D;
  wire D;
  input G;
  wire G;
  reg IQ;
  wire IQN;
  input OE;
  wire OE;
  output Q;
  wire Q;
  assign _0_ = _2_ ? IQ : 1'bz;
  assign _2_ = ~_1_;
  assign IQN = ~IQ;
  always @*
    if (G) IQ = D;
  assign _1_ = ~OE;
  assign Q = _0_;
  specify
    (G => Q) = 0.14;
    (D => Q) = 0.1;
    (OE => Q) = 0.08;
  endspecify
endmodule

module XNOR2_X1(A, B, ZN);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input B;
  wire B;
  output ZN;
  wire ZN;
  assign _0_ = ~_1_;
  assign _1_ = A ^ B;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.12;
    (B => ZN) = 0.12;
  endspecify
endmodule

module XNOR2_X2(A, B, ZN);
  wire _0_;
  wire _1_;
  input A;
  wire A;
  input B;
  wire B;
  output ZN;
  wire ZN;
  assign _0_ = ~_1_;
  assign _1_ = A ^ B;
  assign ZN = _0_;
  specify
    (A => ZN) = 0.1;
    (B => ZN) = 0.1;
  endspecify
endmodule

module XOR2_X1(A, B, Z);
  wire _0_;
  input A;
  wire A;
  input B;
  wire B;
  output Z;
  wire Z;
  assign _0_ = A ^ B;
  assign Z = _0_;
  specify
    (A => Z) = 0.12;
    (B => Z) = 0.12;
  endspecify
endmodule

module XOR2_X2(A, B, Z);
  wire _0_;
  input A;
  wire A;
  input B;
  wire B;
  output Z;
  wire Z;
  assign _0_ = A ^ B;
  assign Z = _0_;
  specify
    (A => Z) = 0.1;
    (B => Z) = 0.1;
  endspecify
endmodule

module CLKGATE_X1 (CK, E, GCK);
  input CK;
  input E;
  output GCK;
  reg IQ;

  always @(CK or E)
    if (!CK) IQ = E;

  assign GCK = CK & IQ;
  specify
    (CK => GCK) = 0.12;
    (E => GCK) = 0.15;
  endspecify
endmodule

module CLKGATE_X2 (CK, E, GCK);
  input CK;
  input E;
  output GCK;
  reg IQ;

  always @(CK or E)
    if (!CK) IQ = E;

  assign GCK = CK & IQ;
  specify
    (CK => GCK) = 0.1;
    (E => GCK) = 0.12;
  endspecify
endmodule

module CLKGATE_X4 (CK, E, GCK);
  input CK;
  input E;
  output GCK;
  reg IQ;

  always @(CK or E)
    if (!CK) IQ = E;

  assign GCK = CK & IQ;
  specify
    (CK => GCK) = 0.08;
    (E => GCK) = 0.1;
  endspecify
endmodule

module CLKGATE_X8 (CK, E, GCK);
  input CK;
  input E;
  output GCK;
  reg IQ;

  always @(CK or E)
    if (!CK) IQ = E;

  assign GCK = CK & IQ;
  specify
    (CK => GCK) = 0.06;
    (E => GCK) = 0.08;
  endspecify
endmodule