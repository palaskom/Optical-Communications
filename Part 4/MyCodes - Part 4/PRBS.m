function PRBSeq = PRBS( N )

%PRBS Returns A Pseudo-Random Bit Sequence of order N. It is generated with
%  by a shifting register and a XOR-gate array defined by a primitive
%  polynomial, characteristic of the order of the PRBS.
%
%Alexandros K. Pitilakis
%The 2nd of November 2008
%Thessaloniki, Greece

%A default value;
if nargin == 0
    N = 7;
end

%Find All Primitive Polynomial of the given PRBS order
AllPrimPolys = primpoly( N , 'all' , 'nodisplay' );

%Check for one that satisfies the constraints
for kkk = 1 : length(AllPrimPolys)
    
    %Get the Polyonimal in a vector format, e.g. [1 0 0 1 1] etc
    p = str2num( dec2bin( AllPrimPolys(kkk) )' );
    
    %Check for Even Non-Zero Terms, excluding the zero-th order
    if mod( sum( p ) , 2 ) == 1                     
        break
    end
    
end

%Indices to the Non-Zero Terms in the 2^[0 1 2 ... n ... order] convention
NZs = find( p == 1 ) - 1;

%Keep only the non-trivial Terms
NZs = NZs(2:end-1);                         

%Pre-Allocate a Matrix to hold the PRBS
PRBSeq = NaN * ones( 1 , 2^N - 1 );

%Initialize Shift-Register, with all ones
Register = ones( 1 , N );

%Shift Register 2^order-1 times to get the PRBS bit-stream
for kkk = 1 : length(PRBSeq)
    
    %Get the Last bit of the register as the PRBS output
    PRBSeq(kkk) = Register(N); 
    
    %The XORs
    NewBit = Register(N); %Initalize, cuz its always present in primpolys
    for mmm = 1 : length(NZs)
        NewBit = xor( Register( NZs(mmm) ) , NewBit );
    end
    
    %Shift the Register and Proceed
    Register = [ NewBit , Register(1:end-1) ];
end

%Test-Plot
if nargout == 0
    figure('Color','w')
    plot(PRBSeq,'bo-')
    axis([1 2^N-1 -0.5 1.5 ])
    title( sprintf('PRBS of order %d and length %d' , N , 2^N-1 ) )
end
