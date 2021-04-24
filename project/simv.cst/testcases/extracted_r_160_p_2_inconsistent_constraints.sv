class c_160_2;
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

program p_160_2;
    c_160_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x0z011zx100z10x00zxxx011x11z01zzzzxzxxxxxxzxxzzzzzzxxzxzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram