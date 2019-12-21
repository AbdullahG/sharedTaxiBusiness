pragma solidity ^0.5.0;

contract SharedTaxiBusiness {
    uint constant maxParticipantLimit = 9;
    address manager;
    address driver;
    uint constant salary = 100;
    address carDealer;
    uint contractBalance = 0;
    uint constant fixedExpenses = 10;
    uint constant fixedExpensePayingPeriodInMonths = 6;
    uint constant participationFee = 100;
    uint constant offerValidityPeriodInDays = 7;

    uint ownedCar;
    CarProposal carProposal;
    CarProposal repurchaseProposal;

    uint creationDate;

    mapping(address => uint) participants;

    modifier onlyManager() {
        require(msg.sender == manager);
        _;
    }

    modifier onlyCarDealer() {
        require(msg.sender == carDealer);
        _;
    }

    function join() external payable {
        require(msg.value == participationFee, 'insufficient fee');
        participants[msg.sender] = msg.value;
    }

    struct CarProposal {
        uint carId;
        uint price;
        uint validUntil;
        bool approved;
    }

    constructor() public {
        manager = msg.sender;
        creationDate = now;
    }

    function setCarDealer(address carDealerAddress) onlyManager private {
        carDealer = carDealerAddress;
    }

    function carProposeToBusiness(uint carId, uint price) onlyCarDealer private {
        // days to secs conversion
        uint validUntil = 60 * 60 * 24 * offerValidityPeriodInDays;
        carProposal = CarProposal({carId: carId, price: price, validUntil: validUntil, approved: false});
    }
}