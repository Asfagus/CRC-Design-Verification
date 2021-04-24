class c_57_2;
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

program p_57_2;
    c_57_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxxx0x0xxx0x0z0x11zz1xzz0100xx10zxxzxzzxxxzxzxzxxzxxzzzzzxxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
