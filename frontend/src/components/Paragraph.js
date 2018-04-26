import React, { Component } from "react";
import PropTypes from "prop-types";
import SegmentGroup from "./SegmentGroup.js";

class Paragraph extends Component {
  render() {
    return (
      <div className="ca-paragraph">
        {this.props.segmentGroups.map((combinations, i) => (
          <SegmentGroup
            combinations={combinations}
            key={i}
            id={this.props.id + "sg" + i}
            updateItemStore={this.props.updateItemStore}
          />
        ))}
      </div>
    );
  }
}

Paragraph.propTypes = {
  segmentGroups: PropTypes.arrayOf(PropTypes.array).isRequired,
  updateItemStore: PropTypes.func.isRequired
};

export default Paragraph;
