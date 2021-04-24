class c_75_2;
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

program p_75_2;
    c_75_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11zx00x1010zz10xz0xzx01z10z0110zxzxzzxzzzzzxxxzxzzxzzzzzxxzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
