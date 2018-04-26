import React, { Component } from "react";
import PropTypes from "prop-types";
import SegmentGroup from "./SegmentGroup.js";

class Paragraph extends Component {
  render() {
    console.log("Paragraph received: " + this.props.segmentGroups);
    return (
      <div className="ca-paragraph">
        {this.props.segmentGroups.map((combinations, i) => (
          <SegmentGroup combinations={combinations} key={i} />
        ))}
      </div>
    );
  }
}

Paragraph.propTypes = {
  segmentGroups: PropTypes.arrayOf(PropTypes.array).isRequired
};

export default Paragraph;
