class c_13_2;
    rand bit[7:0] data_6_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_6_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_6_ != 8'hbc);
    }
endclass

program p_13_2;
    c_13_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0x010xz10111z01z1111x1z1x0zz0xzxzzxxxzxxxxxxxzxxxzxxxzxzzxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram