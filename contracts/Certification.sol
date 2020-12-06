pragma solidity >=0.4.24;

contract Certification {
    constructor() public {}

    struct Certificate {
        string student_name;
        string org_name;
        string course_name;
        uint256 expiration_date;
    }

    mapping(bytes32 => Certificate) public certificates;

    event certificateGenerated(bytes32 _certificateId);

    function converttobytes(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
        assembly {
                result := mload(add(source, 32))
        }
    }

    function storeCertificate(
        string memory _id,
        string memory _student_name,
        string memory _org_name,
        string memory _course_name,
        uint256 _expiration_date) public {
        bytes32 byte_id = converttobytes(_id);
        require(certificates[byte_id].expiration_date == 0, "Duplicate Entry");
        certificates[byte_id] = Certificate(_student_name, _org_name, _course_name, _expiration_date);
        emit certificateGenerated(byte_id);
    }

    function verifyCertificate(string memory _id) public view returns(string memory, string memory, string memory, uint256) {
        bytes32 byte_id = converttobytes(_id);
        Certificate memory temp = certificates[byte_id];
        require(temp.expiration_date != 0, "No such certificate exists");
        return (temp.student_name, temp.org_name, temp.course_name, temp.expiration_date);
    }
}
