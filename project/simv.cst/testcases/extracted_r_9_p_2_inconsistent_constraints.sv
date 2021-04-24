class c_9_2;
    rand bit[7:0] data_8_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_8_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_8_ != 8'hbc);
    }
endclass

program p_9_2;
    c_9_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1x0zxzzzz1zz1x1zx1x1x01101xx0zzzxzxxzzxxzzzxzxzzxzzzzxzxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
