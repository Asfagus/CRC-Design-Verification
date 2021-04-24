class c_141_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_141_2;
    c_141_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z10101xxx1z0zz11z11zxz10zx001x0zzzxzxzxxxzzzzxzxzzzzxxxxxxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
