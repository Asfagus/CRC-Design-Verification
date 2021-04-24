class c_21_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_21_2;
    c_21_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01z1z000z00zz110x1zx01xz1x10x0zzzzxzxxxzzzxxxxzzzxzxxzxxxxzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
