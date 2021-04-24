class c_124_2;
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

program p_124_2;
    c_124_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzxzz001xx0xx0xz10x1xxxx0x00zz10zxxzxxzzxzxzxxzxzzzzxzzzxxzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
