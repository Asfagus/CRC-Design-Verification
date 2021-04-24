class c_79_2;
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

program p_79_2;
    c_79_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0x1zx0xxx101000x10zz1x0011zx1xzxxzxzzxzxzzxzxzxxxxxxzxxxzxzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
