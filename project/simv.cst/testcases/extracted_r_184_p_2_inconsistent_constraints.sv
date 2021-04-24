class c_184_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_184_2;
    c_184_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z001z1xz1x1zx0x0000x0xzxzz110xxxzzzxzxzxzzxzzzxxxzzxxxzzzzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
