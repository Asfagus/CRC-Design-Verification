class c_121_2;
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

program p_121_2;
    c_121_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0010zzx1z11x001z01z101xzx01zzxxzxxzzxxzzzxzxxxxxzzzxxxzxxzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
