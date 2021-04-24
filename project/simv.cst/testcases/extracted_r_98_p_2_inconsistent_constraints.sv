class c_98_2;
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

program p_98_2;
    c_98_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z10z1011x111x1x0z0zxzxx01xx01z0xxxzxxxzzzxzzxzzxxxxxzxxxxzzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
