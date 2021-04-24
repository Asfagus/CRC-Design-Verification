class c_178_2;
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

program p_178_2;
    c_178_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzx1zx1z0zz1z01z1z1x0zx01z1x11zzzxzzxxxxxzzxxzxzzxzxzxxzxzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
