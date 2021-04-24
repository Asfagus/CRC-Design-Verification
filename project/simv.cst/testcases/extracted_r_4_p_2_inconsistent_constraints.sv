class c_4_2;
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

program p_4_2;
    c_4_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0x1zx1xxzz0z01zxzxxzzx1xz1x010xxxxzzxzxzzzxzxzxzzzxzzxzxzxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
