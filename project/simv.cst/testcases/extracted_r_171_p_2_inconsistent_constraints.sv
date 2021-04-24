class c_171_2;
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

program p_171_2;
    c_171_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx0xxxzxxz1xx01z1z1xxx1zz0110zxxzxxzzxzzxxzzzzzzxzxxxzxxxzxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
