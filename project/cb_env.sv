class cb_env extends uvm_env;
`uvm_component_utils(cb_env)
cb_mon_out monout;
cb_scoreboard0 scbd0;
cb_scoreboard8b10b scbd8b10b;
cb_scoreboard1 scbd1;
cb_scoreboard_disparity scbd_disparity;
cb_agent agnt1;
cb_scoreboard_datachk scbd_dc;
cb_scoreboard_checkercrc scbdcrcchecker;
cb_scoreboard_crc scbdcrc;
cb_scoreboard_framein scbd_framein;
cb_scoreboardcrc4packets scbd_4packets;
cb_scoreboard_RD scbd_RD;

function new (string name="cb_env",uvm_component parent =null);
super.new(name,parent);// The super keyword is used from within a derived class to access to members of the parent class.
endfunction :new

function void build_phase(uvm_phase phase);
	scbd0=cb_scoreboard0::type_id::create("scbd0",this);
	scbd8b10b=cb_scoreboard8b10b::type_id::create("scbd8b10b",this);
	scbd1=cb_scoreboard1::type_id::create("scbd1",this);
	agnt1=cb_agent::type_id::create("agnt1",this);
	monout=cb_mon_out::type_id::create("monout",this);
	scbd_disparity=cb_scoreboard_disparity::type_id::create("scbd_disparity",this);
	scbd_dc=cb_scoreboard_datachk::type_id::create("scbd_dc",this);
	scbdcrc=cb_scoreboard_crc::type_id::create("scbdcrc",this);
	scbdcrcchecker=cb_scoreboard_checkercrc::type_id::create("scbdcrcchecker",this);
	scbd_framein=cb_scoreboard_framein::type_id::create("scbd_framein",this);
	scbd_4packets=cb_scoreboardcrc4packets::type_id::create("cb_scoreboardcrc4packets",this);
	scbd_RD=cb_scoreboard_RD::type_id::create("scbd_RD",this);
	
endfunction: build_phase

function void connect_phase(uvm_phase phase);
	agnt1.monin.pdat.connect(scbd0.message_in.analysis_export);	//connects driver to monitor to scbd0
	agnt1.monout.pdat1.connect(scbd1.message_in.analysis_export); //connects DUt to monitor to scbd1
	scbd0.message_out.connect(scbd8b10b.message_in_8b10b.analysis_export);	//connects scbd0 to scbd8b/10b
	scbd0.message_out1.connect(scbdcrc.message_in_scbdcrc.analysis_export);// connects scbd0 to scbdcrc
	scbd8b10b.message_out.connect(scbd_disparity.message_in_scbd8b10b.analysis_export);// connects scbd8b10b to scbd_disparity
	scbd1.message_out.connect(scbd_disparity.message_in_scbd1.analysis_export);// connects scbd1 to scbd_disparity
	scbd8b10b.message_out.connect(scbd_dc.message_in_scbd8b10b.analysis_export);// connects scbd8b10b to scbd_dc
	scbd1.message_out.connect(scbd_dc.message_in_scbd1.analysis_export);// connects scbd1 to scbd_dc
	scbd1.message_out1.connect(scbdcrcchecker.message_in_scbd1a.analysis_export);// connects scbd1 to scbd_crcchecker
	scbd1.message_out2.connect(scbd_4packets.messagecrc4_in_scbd1.analysis_export);// connects scbd1 to scbd_crc4packets
	scbdcrc.message_out_scbdcrc.connect(scbdcrcchecker.message_in_scbdcrca.analysis_export);
	scbd0.message_out2.connect(scbd_framein.message_in_scbd_framein.analysis_export);//connects scbd0 to scbd_framein
	scbd1.message_out.connect(scbd_RD.message_in_scbd1.analysis_export);// new connects scbd1 to scbd_RD
	scbd8b10b.message_out.connect(scbd_RD.message_in_scbd8b10b.analysis_export);

endfunction:connect_phase

task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask : run_phase


endclass: cb_env
