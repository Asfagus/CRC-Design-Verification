class c_38_2;
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

program p_38_2;
    c_38_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x011x01010xz10000xzx1010x00xx0z0xzzxxzxzzxzxzzzzzxxzzxxxxzzzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
