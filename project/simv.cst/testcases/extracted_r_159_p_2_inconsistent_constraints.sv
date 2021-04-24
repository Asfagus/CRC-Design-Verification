class c_159_2;
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

program p_159_2;
    c_159_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x10xxz1010zxzxzz00x10zz0z1100z0xxzzzzxzzxzxzxzxzzzxxzzxxxxxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
