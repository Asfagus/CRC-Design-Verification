class c_132_2;
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

program p_132_2;
    c_132_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x1zxz10xx1x00zx0xzxz1z1x11z1zxxxxzzxxxxzzxxzxxxzzzxxxzxxxxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
