class c_193_2;
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

program p_193_2;
    c_193_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1x0x0zx0x1z1011z0zx1x111x1xz0zxxxzxxxxzxxxxxxzzxzxzzzxxxzxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
