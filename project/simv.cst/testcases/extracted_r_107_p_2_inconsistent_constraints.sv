class c_107_2;
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

program p_107_2;
    c_107_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxx0x01z1zxx00xxzzz11zxxx1000xx0xzxzzzzzxxzxzxzxzxzzxzzzxxzxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
