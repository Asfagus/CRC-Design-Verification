class c_97_2;
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

program p_97_2;
    c_97_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxzz0zx1xx0001z01xz100z1zzx00zz0xxxzxxzxxzzxxxxzzzzzzzxxzzzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
