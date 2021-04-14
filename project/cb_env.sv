class cb_env extends uvm_env;
`uvm_component_utils(cb_env)
//cb_mon_out monout;
//cb_scoreboard0 scbd0;
//cb_scoreboard1 scbd1;
cb_agent agnt1;
function new (string name="cb_env",uvm_component parent =null);
super.new(name,parent);// The super keyword is used from within a derived class to access to members of the parent class.
endfunction :new

function void build_phase(uvm_phase phase);
	//scbd0=cb_scoreboard0::type_id::create("scbd0",this);
	//scbd1=cb_scoreboard1::type_id::create("scbd1",this);
	agnt1=cb_agent::type_id::create("agnt1",this);
	//monout=cb_mon_out::type_id::create("monout",this);
	
endfunction: build_phase

function void connect_phase(uvm_phase phase);
	//agnt1.monin.pdat.connect(scbd0.message_in.analysis_export);
	//monout.pdat1.connect(scbd0.message_out);
	//monout.psc1.connect(scbd1.empty_in.analysis_export);
endfunction:connect_phase

task run_phase(uvm_phase phase);
		super.run_phase(phase);
	endtask : run_phase


endclass: cb_env
