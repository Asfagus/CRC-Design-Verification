class c_101_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_101_2;
    c_101_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx0zx011xx0x0xz111x0xz11zz0x01x0xxzxzxxxxxzxzxxxzxxzzzxzzxzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
