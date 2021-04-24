class c_49_2;
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

program p_49_2;
    c_49_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zzxx10x11zzzxxzxxzxxz1x1x0xzz11xzzxxzzxxzzzxxxxzxzzxzzxxzxxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
