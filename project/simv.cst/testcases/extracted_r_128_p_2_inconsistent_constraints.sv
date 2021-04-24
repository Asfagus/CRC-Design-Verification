class c_128_2;
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

program p_128_2;
    c_128_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0x0z1xx101zz0z1zzx1110101z01z1xxxzzzzzxxzxxxxzzxzxxxxzzzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
