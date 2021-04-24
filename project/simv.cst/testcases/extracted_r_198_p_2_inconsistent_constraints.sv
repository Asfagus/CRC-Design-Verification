class c_198_2;
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

program p_198_2;
    c_198_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1xxxx1xz00xx11xxxz1zx0101xz001xxxzzzxxzzzzxzzzzxzxzxzzxxzxxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram