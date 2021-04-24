class c_45_2;
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

program p_45_2;
    c_45_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0xz0xxzx01xz0x1z0x0xx0x0110xxxxzzzxxxzzzzxzzzxzzzxxzxxzzzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
