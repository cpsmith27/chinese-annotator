import React, { Component } from "react";
import PropTypes from "prop-types";

class SegmentGroup extends Component {
  render() {
    console.log("SegmentGroup: " + this.props.combinations[0]);
    return (
      <span className="ca-segment-group">
        {this.props.combinations[0].join()}
      </span>
    );
  }
}

SegmentGroup.propTypes = {
  combinations: PropTypes.arrayOf(PropTypes.array).isRequired
};

export default SegmentGroup;
