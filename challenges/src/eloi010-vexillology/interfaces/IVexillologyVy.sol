pragma solidity ^0.8.13;

interface IVexillologyVy {
    event FlagFolded(bool);
    event FlagHoisted(bool);
    event FlagInverted(bool);
    event FlagHalfMasted(bool);

    function country_name() external view returns (string memory);
    function country_flag() external view returns (uint256);
    function hoist_flag() external;
    function invert_flag() external;
    function half_mast_flag() external;
    function reset_flag() external;
    function set_captured() external;
    function isSolved() external view returns (bool);
}
