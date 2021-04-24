class c_1_2;
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

program p_1_2;
    c_1_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xzx1zx0x1xx001z1z00x1x010zz0xzxzxzxxzxxxxxxzzxzzzxzzxxzzzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
