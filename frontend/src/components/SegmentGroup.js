import React, { Component } from "react";
import PropTypes from "prop-types";

class SegmentGroup extends Component {
  constructor(props) {
    super(props);
    this.current = props.combinations[0];
  }

  render() {
    this.props.updateItemStore(this.props.id, this.current);
    return <span className="ca-segment-group">{this.current}</span>;
  }
}

SegmentGroup.propTypes = {
  combinations: PropTypes.arrayOf(PropTypes.array).isRequired,
  updateItemStore: PropTypes.func.isRequired
};

export default SegmentGroup;
