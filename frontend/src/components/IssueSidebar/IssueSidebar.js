import React, { useRef, useState } from 'react';
import styled from 'styled-components';
import { OptionSelectModal } from '@components';
import { colors } from '@styles/variables';
import { flex } from '@styles/utils';
import GearIcon from './GearIcon/GearIcon';

const MainContainer = styled.div`
  flex-direction: column;
  flex: 1;
  margin-right: 5rem;
  padding-left: 0.5rem;
`;

const Box = styled.div`
  padding: 1.5rem 1rem 0 1rem;
  font-size: 0.8rem;
  font-weight: bold;
  color: ${colors.black5};
`;

const Line = styled.div`
  height: 0.5px;
  width: 100%;
  margin-top: 1rem;
  background-color: ${colors.lighterGray};
`;

const AssigneeBox = styled(Box)``;
const LabelBox = styled(Box)``;
const MilestoneBox = styled(Box)``;

const Header = styled.div`
  position: relative;
  ${flex('space-between', 'center')}
  cursor: pointer;
  &:hover {
    color: ${colors.resetFilterColor};
    svg {
      fill: ${colors.resetFilterColor};
    }
  }
`;

const Content = styled.div`
  font-weight: 300;
  font-size: 0.75rem;
  padding: 0.8rem 0 0 0;
`;

const AssignMySelfButton = styled.span``;

const Modal = styled.div`
  position: absolute;
  top: 1.8rem;
  right: 0;
  outline: 0;
  z-index: 2;
`;

export default function IssueSidebar(props) {
  const { handleAssignToMe } = props;

  const assigneeModalRef = useRef();
  const labelModalRef = useRef();
  const milestoneModalRef = useRef();

  const [visiableAssigneeModal, setVisiableAssigneeModal] = useState(false);
  const [visiableLabelModal, setVisiableLabelModal] = useState(false);
  const [visiableMilestoneModal, setVisiableMilestoneModal] = useState(false);

  const openAssigneeModal = () => {
    setVisiableAssigneeModal(true);
    assigneeModalRef.current.focus();
  };

  const closeAssigneeModal = () => setVisiableAssigneeModal(false);

  const openLabelModal = () => {
    setVisiableLabelModal(true);
    labelModalRef.current.focus();
  };

  const closeLabelModal = () => setVisiableLabelModal(false);

  const openMilestoneModal = () => {
    setVisiableMilestoneModal(true);
    milestoneModalRef.current.focus();
  };

  const closeMilestoneModal = () => setVisiableMilestoneModal(false);

  return (
    <MainContainer>
      <AssigneeBox>
        <Header onClick={openAssigneeModal}>
          Assignees
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={assigneeModalRef} onBlur={closeAssigneeModal}>
            <OptionSelectModal
              visiable={visiableAssigneeModal}
              setVisiable={setVisiableAssigneeModal}
              title={'Assign up to 10 people to this issue'}
              width={'19rem'}
            ></OptionSelectModal>
          </Modal>
        </Header>
        <Content>
          No one—<AssignMySelfButton onClick={handleAssignToMe}>assign yourself</AssignMySelfButton>
          <Line />
        </Content>
      </AssigneeBox>

      <LabelBox>
        <Header onClick={openLabelModal}>
          Labels
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={labelModalRef} onBlur={closeLabelModal}>
            <OptionSelectModal
              visiable={visiableLabelModal}
              setVisiable={setVisiableLabelModal}
              title={'Apply labels to this issue'}
              width={'19rem'}
            ></OptionSelectModal>
          </Modal>
        </Header>
        <Content>None yet</Content>
        <Line />
      </LabelBox>

      <MilestoneBox>
        <Header onClick={openMilestoneModal}>
          Milestone
          <GearIcon fillColor={colors.black8} />
          <Modal tabIndex={0} ref={milestoneModalRef} onBlur={closeMilestoneModal}>
            <OptionSelectModal
              visiable={visiableMilestoneModal}
              setVisiable={setVisiableMilestoneModal}
              title={'Set milestone'}
              width={'19rem'}
            ></OptionSelectModal>
          </Modal>
        </Header>
        <Content>None yet</Content>
        <Line />
      </MilestoneBox>
    </MainContainer>
  );
}
