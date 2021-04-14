class cb_test extends uvm_test;
`uvm_component_utils(cb_test)
cb_env env1;
cb_seq1 sq1;
function new (string name="cb_test",uvm_component parent =null);
super.new(name,parent);// The super keyword is used from within a derived class to access to members of the parent class.
endfunction :new

function void build_phase(uvm_phase phase);
	env1=cb_env::type_id::create("cb_env1",this);
endfunction: build_phase


task run_phase(uvm_phase phase);
	sq1=cb_seq1::type_id::create("cb_seq1",this);// build the sequences here in this run phase task
	phase.raise_objection(this);// raise and drop objection reqd for running the simulation ??
	sq1.start(env1.agnt1.sqr);//drive sequence to sequencer in the test
	#100;
	phase.drop_objection(this);
endtask:run_phase

endclass: cb_test
