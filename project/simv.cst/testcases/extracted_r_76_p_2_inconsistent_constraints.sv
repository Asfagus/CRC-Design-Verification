class c_76_2;
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

program p_76_2;
    c_76_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "100xx1zzz1101zzx111zxzzzzx1x0x1xxzxxzzzxxzxxzxxxzxxxzzxxzzzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
