class cb_agent extends uvm_agent;
`uvm_component_utils(cb_agent)
cb_seqr sqr;
cb_drv drv;
//cb_mon_in monin;

function new (string name="cb_agent",uvm_component parent =null);
super.new(name,parent);// The super keyword is used from within a derived class to access to members of the parent class.
endfunction :new

function void build_phase(uvm_phase phase);
	sqr=cb_seqr::type_id::create("cb_seqr",this);
	drv=cb_drv::type_id::create("drv",this);
	//monin=cb_mon_in::type_id::create("monin",this);
	
endfunction: build_phase

function void connect_phase(uvm_phase phase);
	drv.seq_item_port.connect(sqr.seq_item_export);// the seq_item_port of driver conected to seq_item_export of sequencer
endfunction:connect_phase


endclass: cb_agent
