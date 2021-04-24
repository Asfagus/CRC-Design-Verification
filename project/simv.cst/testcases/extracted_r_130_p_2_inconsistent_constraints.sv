class c_130_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_130_2;
    c_130_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zx100100zxx1x10z000101xx10000xxxxxxxxxxxxzxzzxzxzxzxzxzzxxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
