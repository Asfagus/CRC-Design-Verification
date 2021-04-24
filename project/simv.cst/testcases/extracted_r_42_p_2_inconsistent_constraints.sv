class c_42_2;
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

program p_42_2;
    c_42_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x101zxz1xx111zzzz1x100101xx10z1xzzzzzxxzzzxxxxxxxzxxzzzxzzxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
