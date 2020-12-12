`timescale 1ns / 1ns

module dff_dlatch
(
	input		CLK,
	input		D,
	output		Q
);

	reg		Q1;
	reg		CLK_BAR;
	
	assign	CLK_BAR = #1 ~CLK;
	
	dlatch dlatch_master
	(
		.C(CLK),
		.D(D),
		.Q(Q1)
	);
	
	dlatch dlatch_slave
	(
		.C(CLK_BAR),
		.D(Q1),
		.Q(Q)
	);
	
endmodule

module dlatch
(
	input		C,
	input		D,
	output		Q
);

	reg			S_BAR;
	reg			R_BAR;
	reg			Q_BAR;
	reg			Q;
	
	assign		S_BAR = #2 ~(D & C);
	assign		R_BAR = #2 ~(~D & C);
	assign		Q = #2 ~(S_BAR & Q_BAR);
	assign		Q_BAR = #2 ~(R_BAR & Q);

endmodule
