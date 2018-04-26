import React, { Component } from "react";
import PropTypes from "prop-types";

class SegmentGroup extends Component {
  constructor(props) {
    super(props);
    this.current = props.segmentations[0];
  }

  render() {
    if (this.props.inDictionary) {
      this.props.updateItemStore(this.props.id, this.current);
      return <span className="ca-segment-group">{this.current}</span>;
    } else {
      return <span>{this.current}</span>;
    }
  }
}

SegmentGroup.propTypes = {
  inDictionary: PropTypes.bool,
  segmentations: PropTypes.arrayOf(PropTypes.arrayOf(PropTypes.string))
    .isRequired,
  updateItemStore: PropTypes.func.isRequired
};

export default SegmentGroup;
