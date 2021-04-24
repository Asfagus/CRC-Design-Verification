class c_197_2;
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

program p_197_2;
    c_197_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0010x1z101xx110z1zz11z10x1zxxzzxxzzzzzzxxxxxzxzxzzxxzxxxxxxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
