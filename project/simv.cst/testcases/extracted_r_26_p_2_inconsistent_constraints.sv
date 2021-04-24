class c_26_2;
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

program p_26_2;
    c_26_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz1zzz00000zx0100xzx1xx0xzxx11z1zzzzxxzzxzzxxzzxxzzxxxzzxzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
